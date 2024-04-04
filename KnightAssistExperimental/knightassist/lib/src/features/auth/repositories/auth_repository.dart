import '../../../core/core.dart';

// Models
import '../enums/auth_endpoint_enum.dart';
import '../models/user_model.dart';

// Helpers
import '../../../helpers/typedefs.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<UserModel> login({
    required JSON data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return await _apiService.setData<UserModel>(
      endpoint: AuthEndpoint.LOGIN.route(),
      data: data,
      requiresAuthToken: false,
      converter: (response) {
        updateTokenCallback(response['token'] as String);
        return UserModel.fromJson(response['user']);
      },
    );
  }

  Future<UserModel> registerVolunteer({
    required JSON data,
  }) async {
    return await _apiService.setData<UserModel>(
      endpoint: AuthEndpoint.REGISTER_VOLUNTEER.route(),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['user_id'],
    );
  }

  Future<UserModel> registerOrganization({
    required JSON data,
  }) async {
    return await _apiService.setData<UserModel>(
      endpoint: AuthEndpoint.REGISTER_ORGANIZATION.route(),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['user_id'],
    );
  }

  Future<String> refreshToken({
    required JSON data,
  }) async {
    return await _apiService.setData<String>(
      endpoint: AuthEndpoint.REFRESH_TOKEN.route(),
      data: data,
      converter: (response) => response['token'],
    );
  }

  Future<String> forgotPassword({
    required JSON data,
  }) async {
    return await _apiService.setData<String>(
      endpoint: AuthEndpoint.FORGOT_PASSWORD.route(),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['message'] as String,
    );
  }
}
