import 'package:dio/dio.dart';

import '../../helper/typedefs.dart';
import '../../models/announcement_model.dart';
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class AnnouncementsRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  AnnouncementsRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<AnnouncementModel>> fetchAll({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData(
      endpoint: ApiEndpoint.announcements(
          AnnouncementEndpoint.FETCH_ALL_ANNOUNCEMENTS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => AnnouncementModel.fromJson(responseBody),
    );
  }

  Future<AnnouncementModel> fetchOne({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData(
      endpoint:
          ApiEndpoint.announcements(AnnouncementEndpoint.FETCH_ANNOUNCEMENT),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => AnnouncementModel.fromJson(responseBody),
    );
  }

  Future<String> create({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint:
          ApiEndpoint.announcements(AnnouncementEndpoint.ADD_ANNOUNCEMENT),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['body']['announcement'] as String,
    );
  }

  Future<String> update({
    required JSON data,
  }) async {
    return await _apiService.updateData(
      endpoint:
          ApiEndpoint.announcements(AnnouncementEndpoint.EDIT_ANNOUNCEMENT),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> delete({
    JSON? data,
  }) async {
    return await _apiService.deleteData(
      endpoint:
          ApiEndpoint.announcements(AnnouncementEndpoint.DELETE_ANNOUNCEMENT),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<List<AnnouncementModel>> fetchFavorited({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData(
      endpoint: ApiEndpoint.announcements(
          AnnouncementEndpoint.FETCH_FAVORITED_ORG_ANNOUNCEMENTS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => AnnouncementModel.fromJson(responseBody),
    );
  }
}
