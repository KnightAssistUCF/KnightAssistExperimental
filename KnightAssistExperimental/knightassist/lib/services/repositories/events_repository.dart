import 'package:dio/dio.dart';
import 'package:knightassist/models/event_model.dart';

import '../../helper/typedefs.dart';
import '../networking/api_service.dart';

class EventsRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  EventsRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<String> create({
    required JSON data,
  }) async {
    return await _apiService.setData(
      // TODO: Set endpoint for creating event
      endpoint: '',
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['body']['event_id'] as String,
    );
  }

  Future<String> update({
    required String eventId,
    required JSON data,
  }) async {
    return await _apiService.updateData(
      // TODO: Set endpoint for updating event
      endpoint: '',
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> delete({
    required String eventId,
    JSON? data,
  }) async {
    return await _apiService.deleteData(
      // TODO: Set endpoint for deleting event
      endpoint: '',
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<List<EventModel>> fetchAll({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData(
        // TODO: Set endpoint for fetching list of events
        endpoint: '',
        queryParams: queryParameters,
        cancelToken: _cancelToken,
        converter: (responseBody) => EventModel.fromJson(responseBody));
  }

  Future<EventModel> fetchOne({
    required String eventId,
  }) async {
    return await _apiService.getDocumentData(
      // TODO: Set endpoint for fetching event
      endpoint: '',
      cancelToken: _cancelToken,
      converter: (responseBody) => EventModel.fromJson(responseBody),
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
