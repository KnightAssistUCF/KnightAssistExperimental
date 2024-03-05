import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/event_links_model.dart';
import '../models/event_model.dart';

import '../models/s3_bucket_image_model.dart';
import '../services/repositories/events_repository.dart';

import 'all_providers.dart';

final eventsFuture = FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final _eventsProvider = ref.watch(eventsProvider);

  return await _eventsProvider.getAllEvents();
});

final selectedEventProvider = StateProvider<EventModel>((ref) {
  return EventModel.initial();
});

class EventsProvider {
  final EventsRepository _eventsRepository;
  EventsProvider(this._eventsRepository);

  Future<List<EventModel>> getAllEvents() async {
    return await _eventsRepository.fetchAll();
  }

  Future<EventModel> getEventById({required String eventId}) async {
    final queryParams = {
      'eventId': eventId,
    };
    return await _eventsRepository.fetchOne(queryParameters: queryParams);
  }

  Future<EventModel> createEvent({
    required String name,
    required String description,
    required String location,
    required String sponsoringOrganization,
    required DateTime startTime,
    required DateTime endTime,
    required EventLinksModel eventLinks,
    required List<String> eventTags,
    required String semester,
    required int maxAttendees,
    required S3BucketImageModel image,
  }) async {
    final event = EventModel(
      eventId: null,
      name: name,
      description: description,
      location: location,
      sponsoringOrganization: sponsoringOrganization,
      registeredVolunteers: [],
      startTime: startTime,
      endTime: endTime,
      eventLinks: eventLinks,
      checkedInVolunteers: [],
      feedback: [],
      eventTags: eventTags,
      semester: semester,
      maxAttendees: maxAttendees,
      image: image,
    );

    final data = <String, Object?>{
      ...event.toJson(),
    };
    final eventId = await _eventsRepository.create(data: data);
    return event.copyWith(eventId: eventId);
  }

  Future<String> editEvent({
    required EventModel event,
    String? name,
    String? description,
    String? location,
    DateTime? startTime,
    DateTime? endTime,
    EventLinksModel? eventLinks,
    List<String>? eventTags,
    String? semester,
    int? maxAttendees,
  }) async {
    final data = event.toUpdateJson(
      name: name,
      description: description,
      location: location,
      startTime: startTime,
      endTime: endTime,
      eventTags: eventTags,
      semester: semester,
      maxAttendees: maxAttendees,
    );
    if (data.isEmpty) return "nothing to update";
    return await _eventsRepository.update(data: data);
  }

  Future<String> deleteEvent({
    required String eventId,
  }) async {
    final data = {
      'eventId': eventId,
    };
    return await _eventsRepository.delete(data: data);
  }

  Future<List<EventModel>> getOrgEvents({
    required String orgId,
  }) async {
    final queryParams = {
      'orgId': orgId,
    };
    return await _eventsRepository.fetchOrgEvents(queryParameters: queryParams);
  }

  Future<List<EventModel>> getRsvpedEvents({
    required String userId,
  }) async {
    final queryParams = {
      'userId': userId,
    };
    return await _eventsRepository.fetchRsvpedEvents(
        queryParameters: queryParams);
  }

  Future<List<EventModel>> getFavoritedOrgEvents({
    required String userId,
  }) async {
    final queryParams = {
      'userId': userId,
    };
    return await _eventsRepository.fetchFavoritedOrgsEvents(
        queryParameters: queryParams);
  }

  Future<List<EventModel>> getSuggestedEvents({
    required String userId,
  }) async {
    final queryParams = {
      'userId': userId,
    };
    return await _eventsRepository.fetchSuggestedEvents(
        queryParameters: queryParams);
  }

  void cancelNetworkRequest() {
    _eventsRepository.cancelRequests();
  }
}
