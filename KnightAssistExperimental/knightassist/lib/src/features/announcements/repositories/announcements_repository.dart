import 'package:dio/dio.dart';

import '../../../core/core.dart';
import '../../../helpers/typedefs.dart';
import '../enums/announcements_endpoint_enum.dart';
import '../models/announcement_model.dart';

class AnnouncementsRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  AnnouncementsRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<AnnouncementModel>> fetchAllAnnouncements({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData(
      endpoint: AnnouncementsEndpoint.FETCH_ALL_ANNOUNCEMENTS.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: AnnouncementModel.fromJson,
    );
  }

  Future<AnnouncementModel> fetchAnnouncement({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData(
      endpoint: AnnouncementsEndpoint.FETCH_ANNOUNCEMENT.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: AnnouncementModel.fromJson,
    );
  }

  Future<String> addAnnouncement({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: AnnouncementsEndpoint.ADD_ANNOUNCEMENT.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response as String,
    );
  }

  Future<String> editAnnouncement({
    required JSON data,
  }) async {
    return await _apiService.updateData(
      endpoint: AnnouncementsEndpoint.EDIT_ANNOUNCEMENT.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response as String,
    );
  }

  Future<String> deleteAnnouncement({
    JSON? data,
  }) async {
    return await _apiService.deleteData(
      endpoint: AnnouncementsEndpoint.DELETE_ANNOUNCEMENT.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response as String,
    );
  }

  Future<List<AnnouncementModel>> fetchFavoritedOrgAnnouncements({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData(
      endpoint: AnnouncementsEndpoint.FETCH_FAVORITED_ORG_ANNOUNCEMENTS.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => AnnouncementModel.fromJson(responseBody),
    );
  }
}
