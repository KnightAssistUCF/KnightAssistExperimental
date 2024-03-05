import 'package:dio/dio.dart';

import '../../helper/typedefs.dart';
import '../../models/volunteer_model.dart';
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class VolunteersRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  VolunteersRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<VolunteerModel> fetchOne({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData<VolunteerModel>(
      endpoint: ApiEndpoint.volunteers(VolunteerEndpoint.FETCH_VOLUNTEER),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => VolunteerModel.fromJson(responseBody),
    );
  }

  // Create should be handled by register function

  Future<String> update({
    required JSON data,
  }) async {
    return await _apiService.updateData<String>(
      endpoint: ApiEndpoint.volunteers(VolunteerEndpoint.EDIT_VOLUNTEER),
      data: data,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> delete({
    required JSON data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: ApiEndpoint.volunteers(VolunteerEndpoint.DELETE_VOLUNTEER),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<List<VolunteerModel>> fetchVolunteersInOrg({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<VolunteerModel>(
      endpoint:
          ApiEndpoint.volunteers(VolunteerEndpoint.FETCH_VOLUNTEERS_IN_ORG),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => VolunteerModel.fromJson(responseBody),
    );
  }

  Future<List<VolunteerModel>> fetchEventAttendees({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<VolunteerModel>(
      endpoint: ApiEndpoint.volunteers(VolunteerEndpoint.FETCH_EVENT_ATTENDEES),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => VolunteerModel.fromJson(responseBody),
    );
  }

  Future<List<VolunteerModel>> fetchLeaderboard({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData<VolunteerModel>(
      endpoint: ApiEndpoint.volunteers(VolunteerEndpoint.FETCH_LEADERBOARD),
      cancelToken: _cancelToken,
      queryParams: queryParameters,
      converter: (responseBody) => VolunteerModel.fromJson(responseBody),
    );
  }

  Future<List<VolunteerModel>> fetchOrgLeaderboard({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<VolunteerModel>(
      endpoint: ApiEndpoint.volunteers(VolunteerEndpoint.FETCH_ORG_LEADERBOARD),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => VolunteerModel.fromJson(responseBody),
    );
  }

  Future<String> addFavoriteOrg({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: ApiEndpoint.volunteers(VolunteerEndpoint.ADD_FAVORITE_ORG),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> removeFavoriteOrg({
    required JSON data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: ApiEndpoint.volunteers(VolunteerEndpoint.REMOVE_FAVORITE_ORG),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
