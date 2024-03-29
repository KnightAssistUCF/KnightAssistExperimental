import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../../../global/states/auth_state.codegen.dart';
import '../../../global/states/future_state.codegen.dart';
import '../enums/user_role_enum.dart';
import '../models/user_model.dart';

// Repositories
import '../repositories/auth_repository.dart';

final editProfileStateProvider = StateProvider<FutureState<String>>(
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

  String get currentUserId => _currentUser!.id;

  String get currentUserEmail => _currentUser!.email;

  String? get currentUserOrgName {
    if (_currentUser!.role == UserRole.ORGANIZATION) {
      return _currentUser!.orgName!;
    } else {
      return null;
    }
  }

  String? get currentUserFirstName {
    if (_currentUser!.role == UserRole.VOLUNTEER) {
      return _currentUser!.firstName!;
    } else {
      return null;
    }
  }

  String? get currentUserLastName {
    if (_currentUser!.role == UserRole.VOLUNTEER) {
      return _currentUser!.lastName!;
    } else {
      return null;
    }
  }

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
    final data = <String, dynamic>{'email': email, 'password': password};
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
  }) async {
    final volunteer = <String, dynamic>{
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
    state = const AuthState.authenticating();
    try {
      _currentUser = await _authRepository.registerVolunteer(data: volunteer);
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
    required String orgName,
  }) async {
    final organization = <String, dynamic>{
      'email': email,
      'password': password,
      'name': orgName,
    };
    try {
      _currentUser =
          await _authRepository.registerOrganization(data: organization);
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
