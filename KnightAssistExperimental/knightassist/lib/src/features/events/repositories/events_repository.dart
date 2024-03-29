// Networking
import '../../../core/core.dart';

// Models
import '../enums/events_endpoint_enum.dart';
import '../models/event_model.dart';

// Helpers
import '../../../helpers/typedefs.dart';

class EventsRepository {
  final ApiService _apiService;

  EventsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<EventModel>> fetchAllEvents({JSON? queryParameters}) async {
    return _apiService.getCollectionData<EventModel>(
      endpoint: EventsEndpoint.FETCH_ALL_EVENTS.route(),
      queryParams: queryParameters,
      converter: EventModel.fromJson,
    );
  }

  Future<EventModel> fetchEvent({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData(
      endpoint: EventsEndpoint.FETCH_EVENT.route(),
      queryParams: queryParameters,
      converter: EventModel.fromJson,
    );
  }

  Future<String> addEvent({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: EventsEndpoint.ADD_EVENT.route(),
      data: data,
      converter: (response) => response['body']['event_id'],
    );
  }

  Future<String> editEvent({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: EventsEndpoint.EDIT_EVENT.route(),
      data: data,
      converter: (response) => response['headers']['message'],
    );
  }

  Future<String> deleteEvent({
    JSON? data,
  }) async {
    return await _apiService.deleteData(
      endpoint: EventsEndpoint.DELETE_EVENT.route(),
      data: data,
      converter: (response) => response['headers']['message'],
    );
  }

  Future<List<EventModel>> fetchOrgEvents({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<EventModel>(
      endpoint: EventsEndpoint.FETCH_ORG_EVENTS.route(),
      queryParams: queryParameters,
      converter: EventModel.fromJson,
    );
  }

  Future<List<EventModel>> fetchRsvpedEvents({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<EventModel>(
      endpoint: EventsEndpoint.FETCH_RSVPED_EVENTS.route(),
      queryParams: queryParameters,
      converter: EventModel.fromJson,
    );
  }

  Future<List<EventModel>> fetchFavoritedOrgsEvents({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<EventModel>(
      endpoint: EventsEndpoint.FETCH_FAVORITED_ORGS_EVENTS.route(),
      queryParams: queryParameters,
      converter: EventModel.fromJson,
    );
  }

  Future<List<EventModel>> fetchSuggestedEvents({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<EventModel>(
      endpoint: EventsEndpoint.FETCH_SUGGESTED_EVENTS.route(),
      queryParams: queryParameters,
      converter: EventModel.fromJson,
    );
  }

  Future<String> addRsvp({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: EventsEndpoint.ADD_RSVP.route(),
      data: data,
      converter: (response) => response['headers']['message'],
    );
  }

  Future<String> removeRsvp({
    JSON? data,
  }) async {
    return await _apiService.deleteData(
      endpoint: EventsEndpoint.REMOVE_RSVP.route(),
      data: data,
      converter: (response) => response['headers']['message'],
    );
  }
}
