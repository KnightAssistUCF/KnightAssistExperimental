import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/user_role_enum.dart';

import '../models/user_model.dart';

import '../services/local_storage/key_value_storage_service.dart';
import '../services/networking/network_exception.dart';
import '../services/repositories/auth_repository.dart';

import 'states/auth_state.dart';
import 'states/future_state.dart';

final changePasswordStateProvider = StateProvider<FutureState<String>>(
  (ref) => const FutureState<String>.idle(),
);

class AuthProvider extends StateNotifier<AuthState> {
  late UserModel? _currentUser;
  final AuthRepository _authRepository;
  final KeyValueStorageService _keyValueStorageService;
  final Ref _ref;
  String _password = '';

  AuthProvider({
    required AuthRepository authRepository,
    required KeyValueStorageService keyValueStorageService,
    required Ref ref,
  })  : _authRepository = authRepository,
        _keyValueStorageService = keyValueStorageService,
        _ref = ref,
        super(const AuthState.unauthenticated()) {
    init();
  }

  String get currentUserId => _currentUser!.userId!;

  String get currentUserEmail => _currentUser!.email;

  String get currentUserPassword => _password;

  UserRole get currentUserRole => _currentUser!.role;

  void updateToken(String value) {
    _keyValueStorageService.setAuthToken(value);
  }

  void _updatePassword(String value) {
    _password = value;
    _keyValueStorageService.setAuthPassword(value);
  }

  void init() async {
    final authenticated = _keyValueStorageService.getAuthState();
    _currentUser = _keyValueStorageService.getAuthUser();
    _password = await _keyValueStorageService.getAuthPassword();
    if (!authenticated || _currentUser == null || _password.isEmpty) {
      logout();
    } else {
      state = AuthState.authenticated(email: _currentUser!.email);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final data = {'email': email, 'password': password};
    state = const AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendLoginData(
        data: data,
        updateTokenCallback: updateToken,
      );
      state = AuthState.authenticated(email: _currentUser!.email);
      _updatePassword(password);
      _updateAuthProfile();
    } on NetworkException catch (e) {
      state = AuthState.failed(reason: e.message);
    }
  }

  Future<void> registerVolunteer({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    UserRole role = UserRole.VOLUNTEER,
  }) async {
    final volunteer = UserModel(
      userId: null,
      firstName: firstName,
      lastName: lastName,
      email: email,
      role: role,
    );
    state = const AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendRegisterVolunteerData(
        data: volunteer.toJson(),
        updateTokenCallback: updateToken,
      );
      state = AuthState.authenticated(email: _currentUser!.email);
      _updatePassword(password);
      _updateAuthProfile();
    } on NetworkException catch (e) {
      state = AuthState.failed(reason: e.message);
    }
  }

  Future<void> registerOrganization({
    required String email,
    required String password,
    required String name,
    UserRole role = UserRole.ORGANIZATION,
  }) async {
    final organization =
        UserModel(userId: null, name: name, email: email, role: role);
    state = const AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendRegisterOrganizationData(
        data: organization.toJson(),
        updateTokenCallback: updateToken,
      );
      state = AuthState.authenticated(email: _currentUser!.email);
      _updatePassword(password);
      _updateAuthProfile();
    } on NetworkException catch (e) {
      state = AuthState.failed(reason: e.message);
    }
  }

  Future<void> changePassword({required String newPassword}) async {
    final data = {
      'email': currentUserEmail,
      'password': currentUserPassword,
      'new_password': newPassword,
    };
    final _changePasswordState = _ref.read(changePasswordStateProvider.state);
    _changePasswordState.state = const FutureState.loading();
    try {
      final result = await _authRepository.sendChangePasswordData(data: data);
      _updatePassword(newPassword);
      _changePasswordState.state = FutureState.data(data: result);
    } on NetworkException catch (e) {
      _changePasswordState.state = FutureState.failed(reason: e.message);
    }
  }

  void _updateAuthProfile() {
    _keyValueStorageService.setAuthState(state);
    _keyValueStorageService.setAuthUser(_currentUser!);
  }

  void logout() {
    _currentUser = null;
    _password = '';
    state = const AuthState.unauthenticated();
    _keyValueStorageService.resetKeys();
  }
}
