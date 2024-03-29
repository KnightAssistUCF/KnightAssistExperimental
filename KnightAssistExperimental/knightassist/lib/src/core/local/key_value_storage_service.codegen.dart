// Services
// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/models/user_model.dart';
import '../../global/states/auth_state.codegen.dart';
import '../../helpers/typedefs.dart';
import 'key_value_storage_base.dart';

part 'key_value_storage_service.codegen.g.dart';

/// A provider used to access instance of this service
@Riverpod(keepAlive: true)
KeyValueStorageService keyValueStorageService(KeyValueStorageServiceRef ref) {
  return KeyValueStorageService();
}

/// A service class for providing methods to store and retrieve key-value data
/// from common or secure storage.
class KeyValueStorageService {
  static const _authTokenKey = 'authToken';
  static const _authStateKey = 'authStateKey';
  static const _authPasswordKey = 'authPasswordKey';
  static const _authUserKey = 'authUserKey';

  final _keyValueStorage = KeyValueStorageBase.instance;

  Future<String> getAuthPassword() async {
    return await _keyValueStorage.getEncrypted(_authPasswordKey) ?? '';
  }

  bool getAuthState() {
    return _keyValueStorage.getCommon<bool>(_authStateKey) ?? false;
  }

  UserModel? getAuthUser() {
    final user = _keyValueStorage.getCommon<String>(_authUserKey);
    if (user == null) return null;
    return UserModel.fromJson(jsonDecode(user) as JSON);
  }

  Future<String> getAuthToken() async {
    return await _keyValueStorage.getEncrypted(_authTokenKey) ?? '';
  }

  void setAuthPassword(String password) {
    _keyValueStorage.setEncrypted(_authPasswordKey, password);
  }

  void setAuthState(AuthState authState) {
    if (authState is AUTHENTICATED) {
      _keyValueStorage.setCommon<bool>(_authStateKey, true);
    }
  }

  void setAuthUser(UserModel user) {
    JSON json = {
      '_id': user.id,
      'email': user.email,
      'role': UserModel.userRoleEnumMap[user.role],
      'firstName': user.firstName,
      'lastName': user.lastName,
      'name': user.orgName
    };
    _keyValueStorage.setCommon(_authUserKey, jsonEncode(json));
  }

  void setAuthToken(String token) {
    _keyValueStorage.setEncrypted(_authTokenKey, token);
  }

  void resetKeys() {
    _keyValueStorage.clearCommon();
    _keyValueStorage.clearEncrypted();
  }
}
