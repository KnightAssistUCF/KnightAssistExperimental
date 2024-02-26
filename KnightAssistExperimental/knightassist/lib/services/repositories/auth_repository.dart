import '../../helper/typedefs.dart';
import '../../models/user_model.dart';
import '../networking/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<UserModel> sendLoginData({
    required JSON data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return await _apiService.setData<UserModel>(
      // TODO: Add correct endpoint for login
      endpoint: '',
      data: data,
      requiresAuthToken: false,
      converter: (response) {
        updateTokenCallback(response['body']['token'] as String);
        return UserModel.fromJson(response['body'] as JSON);
      },
    );
  }

  Future<UserModel> sendRegisterVolunteerData({
    required JSON data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return await _apiService.setData<UserModel>(
      // TODO: Add correct endpoint for register volunteer
      endpoint: '',
      data: data,
      requiresAuthToken: false,
      converter: (response) {
        updateTokenCallback(response['body']['token'] as String);
        data['user_id'] = response['body']['user_id'];
        return UserModel.fromJson(data);
      },
    );
  }

  Future<UserModel> sendRegisterOrganizationData({
    required JSON data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return await _apiService.setData<UserModel>(
      // TODO: Add correct endpoint for register org
      endpoint: '',
      data: data,
      requiresAuthToken: false,
      converter: (response) {
        updateTokenCallback(response['body']['token'] as String);
        data['user_id'] = response['body']['user_id'];
        return UserModel.fromJson(data);
      },
    );
  }

  Future<String> sendForgotPasswordData({
    required JSON data,
  }) async {
    return await _apiService.setData<String>(
      // TODO: Add correct endpoint for forgot password
      endpoint: '',
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> sendResetPasswordData({
    required JSON data,
  }) async {
    return await _apiService.setData<String>(
      // TODO: Add correct endpoint for reset password
      endpoint: '',
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> sendChangePasswordData({
    required JSON data,
  }) async {
    return await _apiService.setData<String>(
      // TODO: Add correct endpoint for change password
      endpoint: '',
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> sendOtpData({required JSON data}) async {
    return await _apiService.setData<String>(
      // TODO: Add correct endpoint for OTP
      endpoint: '',
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['headers']['message'] as String,
    );
  }
}
