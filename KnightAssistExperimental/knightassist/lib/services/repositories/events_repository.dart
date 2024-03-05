import 'package:dio/dio.dart';
import 'package:knightassist/models/event_model.dart';

import '../../helper/typedefs.dart';
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class EventsRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  EventsRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<EventModel>> fetchAll({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData(
        endpoint: ApiEndpoint.events(EventEndpoint.FETCH_ALL_EVENTS),
        queryParams: queryParameters,
        cancelToken: _cancelToken,
        converter: (responseBody) => EventModel.fromJson(responseBody));
  }

  Future<EventModel> fetchOne({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData(
      endpoint: ApiEndpoint.events(EventEndpoint.FETCH_EVENT),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => EventModel.fromJson(responseBody),
    );
  }

  Future<String> create({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: ApiEndpoint.events(EventEndpoint.ADD_EVENT),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['body']['event_id'] as String,
    );
  }

  Future<String> update({
    required JSON data,
  }) async {
    return await _apiService.updateData(
      endpoint: ApiEndpoint.events(EventEndpoint.EDIT_EVENT),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> delete({
    JSON? data,
  }) async {
    return await _apiService.deleteData(
      endpoint: ApiEndpoint.events(EventEndpoint.DELETE_EVENT),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<List<EventModel>> fetchOrgEvents({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData(
      endpoint: ApiEndpoint.events(EventEndpoint.FETCH_ORG_EVENTS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => EventModel.fromJson(responseBody),
    );
  }

  Future<List<EventModel>> fetchRsvpedEvents({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData(
      endpoint: ApiEndpoint.events(EventEndpoint.FETCH_RSVPED_EVENTS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => EventModel.fromJson(responseBody),
    );
  }

  Future<List<EventModel>> fetchFavoritedOrgsEvents({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<EventModel>(
      endpoint: ApiEndpoint.events(EventEndpoint.FETCH_FAVORITED_ORGS_EVENTS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => EventModel.fromJson(responseBody),
    );
  }

  Future<List<EventModel>> fetchSuggestedEvents({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData(
      endpoint: ApiEndpoint.events(EventEndpoint.FETCH_SUGGESTED_EVENTS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => EventModel.fromJson(responseBody),
    );
  }

  Future<String> addRsvp({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: ApiEndpoint.events(EventEndpoint.ADD_RSVP),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> removeRsvp({
    JSON? data,
  }) async {
    return await _apiService.deleteData(
      endpoint: ApiEndpoint.events(EventEndpoint.REMOVE_RSVP),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
