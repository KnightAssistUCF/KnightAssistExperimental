import 'dart:convert';

import 'package:knightassist/helper/typedefs.dart';

import '../../models/user_model.dart';
import '../../providers/states/auth_state.dart';
import 'key_value_storage_base.dart';

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
    _keyValueStorage.setCommon(_authUserKey, jsonEncode(user.toJson()));
  }

  void setAuthToken(String token) {
    _keyValueStorage.setEncrypted(_authTokenKey, token);
  }

  void resetKeys() {
    _keyValueStorage.clearCommon();
    _keyValueStorage.clearEncrypted();
  }
}
