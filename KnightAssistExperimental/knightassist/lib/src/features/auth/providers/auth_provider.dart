import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../../../global/states/auth_state.codegen.dart';
import '../../../global/states/future_state.codegen.dart';
import '../enums/user_role_enum.dart';
import '../models/user_model.codegen.dart';

// Repositories
import '../repositories/auth_repository.dart';

final changePasswordStateProvider = StateProvider<FutureState<String>>(
  (ref) => const FutureState<String>.idle(),
);

class AuthProvider extends StateNotifier<AuthState> {
  late UserModel? _currentUser;
  final AuthRepository _authRepository;
  final KeyValueStorageService _keyValueStorageService;
  String _password = '';

  AuthProvider({
    required AuthRepository authRepository,
    required KeyValueStorageService keyValueStorageService,
  })  : _authRepository = authRepository,
        _keyValueStorageService = keyValueStorageService,
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
      _currentUser = await _authRepository.login(
        data: data,
        updateTokenCallback: updateToken,
      );
      state = AuthState.authenticated(email: _currentUser!.email);
      _updatePassword(password);
      _updateAuthProfile();
    } on CustomException catch (e) {
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
      _currentUser = await _authRepository.registerVolunteer(
        data: volunteer.toJson(),
      );
      state = AuthState.authenticated(email: _currentUser!.email);
      _updatePassword(password);
      _updateAuthProfile();
    } on CustomException catch (e) {
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
      _currentUser = await _authRepository.registerOrganization(
        data: organization.toJson(),
      );
      state = AuthState.authenticated(email: _currentUser!.email);
      _updatePassword(password);
      _updateAuthProfile();
    } on CustomException catch (e) {
      state = AuthState.failed(reason: e.message);
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
