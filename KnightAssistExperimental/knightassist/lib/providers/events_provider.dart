import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/models/event_links_model.dart';

import '../models/event_model.dart';
import 'all_providers.dart';

final eventsFuture = FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final _eventsProvider = ref.watch(eventsProvider);

  return await _eventsProvider.getAllEvents();
});

final selectedEventProvider = StateProvider<EventModel>((ref) {
  return EventModel.initial();
});

class EventsProvider {
  final EventsRepository = _eventsRepository;
  EventsProvider(this._eventsRepository);

  Future<List<EventModel>> getAllEvents() async {
    // TODO: Handle query params
    return await _eventsRepository.fetchAll();
  }

  Future<EventModel> getEventById({required String eventId}) async {
    return await _eventsRepository.fetchOne(eventId: eventId);
  }

  Future<EventModel> createNewEvent({
    required String name,
    required String description,
    required String location,
    required String sponsoringOrganization,
    required List<String> registeredVolunteers,
    required DateTime startTime,
    required DateTime endTime,
    required EventLinksModel eventLinks,
    required List<String> eventTags,
    required String semester,
    required int maxAttendees,
  }) async {
    final event = EventModel(
        eventId: null,
        name: name,
        description: description,
        location: location,
        sponsoringOrganization: sponsoringOrganization,
        registeredVolunteers: registeredVolunteers,
        startTime: startTime,
        endTime: endTime,
        eventLinks: eventLinks,
        eventTags: eventTags,
        semester: semester,
        maxAttendees: maxAttendees);

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
    return await _eventsRepository.update(eventId: event.eventId!, data: data);
  }

  Future<String> removeEvent({
    required String eventId,
  }) async {
    return await _eventsRepository.delete(eventId: eventId);
  }

  void cancelNetworkRequest() {
    _eventsRepository.cancelRequests();
  }
}
