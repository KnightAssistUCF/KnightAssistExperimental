import 'package:dio/dio.dart';

import '../../../core/core.dart';
import '../../../helpers/typedefs.dart';
import '../enums/volunteers_endpoint_enum.dart';
import '../models/volunteer_model.dart';

class VolunteersRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  VolunteersRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<VolunteerModel> fetchVolunteer({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData<VolunteerModel>(
      endpoint: VolunteersEndpoint.FETCH_VOLUNTEER.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: VolunteerModel.fromJson,
    );
  }

  // Create should be handled by register function

  Future<String> update({
    required JSON data,
  }) async {
    return await _apiService.updateData<String>(
      endpoint: VolunteersEndpoint.EDIT_VOLUNTEER.route(),
      data: data,
      converter: (response) => response as String,
    );
  }

  Future<String> delete({
    required JSON data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: VolunteersEndpoint.DELETE_VOLUNTEER.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response as String,
    );
  }

  Future<List<VolunteerModel>> fetchVolunteersInOrg({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<VolunteerModel>(
      endpoint: VolunteersEndpoint.FETCH_VOLUNTEERS_IN_ORG.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => VolunteerModel.fromJson(responseBody),
    );
  }

  Future<List<VolunteerModel>> fetchEventAttendees({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<VolunteerModel>(
      endpoint: VolunteersEndpoint.FETCH_EVENT_ATTENDEES.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => VolunteerModel.fromJson(responseBody),
    );
  }

  Future<List<VolunteerModel>> fetchLeaderboard({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData<VolunteerModel>(
      endpoint: VolunteersEndpoint.FETCH_LEADERBOARD.route(),
      cancelToken: _cancelToken,
      queryParams: queryParameters,
      converter: (responseBody) => VolunteerModel.fromJson(responseBody),
    );
  }

  Future<List<VolunteerModel>> fetchOrgLeaderboard({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<VolunteerModel>(
      endpoint: VolunteersEndpoint.FETCH_ORG_LEADERBOARD.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => VolunteerModel.fromJson(responseBody),
    );
  }

  Future<String> addFavoriteOrg({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: VolunteersEndpoint.ADD_FAVORITE_ORG.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'],
    );
  }

  Future<String> removeFavoriteOrg({
    required JSON data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: VolunteersEndpoint.REMOVE_FAVORITE_ORG.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'],
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
