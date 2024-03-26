import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

// Models
import '../../../core/networking/custom_exception.dart';
import '../../../global/states/edit_state.codegen.dart';
import '../../images/models/s3_bucket_image_model.codegen.dart';
import '../models/event_model.codegen.dart';

// Repositories
import '../repositories/events_repository.dart';

final allEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final _eventsProvider = ref.watch(eventsProvider);

  return await _eventsProvider.getAllEvents();
});

// Only call this if user role is org
final orgEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final _userId = ref.watch(authProvider.notifier).currentUserId;
  final _eventsProvider = ref.watch(eventsProvider);
  return await _eventsProvider.getOrgEvents(orgId: _userId);
});

// Only call these if user role is volunteer
final suggestedEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final _userId = ref.watch(authProvider.notifier).currentUserId;
  final _eventsProvider = ref.watch(eventsProvider);
  return await _eventsProvider.getSuggestedEvents(userId: _userId);
});

final favOrgEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final _userId = ref.watch(authProvider.notifier).currentUserId;
  final _eventsProvider = ref.watch(eventsProvider);
  return await _eventsProvider.getFavoritedOrgEvents(userId: _userId);
});

final rsvpedEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final _userId = ref.watch(authProvider.notifier).currentUserId;
  final _eventsProvider = ref.watch(eventsProvider);
  return await _eventsProvider.getRsvpedEvents(userId: _userId);
});

final eventStateProvider = StateProvider<EditState>((ref) {
  return const EditState.unprocessed();
});

final currentEventProvider = StateProvider<EventModel?>((ref) {
  return EventModel.initial();
});

class EventsProvider {
  final EventsRepository _eventsRepository;
  final Ref _ref;

  EventsProvider({
    required EventsRepository eventsRepository,
    required Ref ref,
  })  : _eventsRepository = eventsRepository,
        _ref = ref,
        super();

  Future<List<EventModel>> getAllEvents([String? searchTerm]) async {
    final queryParams = <String, Object>{
      if (searchTerm != null) 'searchTerm': searchTerm,
    };
    return _eventsRepository.fetchAllEvents(queryParameters: queryParams);
  }

  Future<EventModel> getEventById({
    required String eventId,
  }) async {
    final queryParams = {
      'eventId': eventId,
    };
    return await _eventsRepository.fetchEvent(queryParameters: queryParams);
  }

  Future<void> createEvent({
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
    final data = <String, Object>{
      'name': name,
      'description': description,
      'location': location,
      'sponsoringOrganization': sponsoringOrganization,
      'registeredVolunteers': [],
      'startTime': startTime,
      'endTime': endTime,
      'eventLinks': eventLinks,
      'checkedInVolunteers': [],
      'feedback': [],
      'eventTags': eventTags,
      'semester': semester,
      'maxAttendees': maxAttendees,
      'image': image,
    };

    final _eventStateProv = _ref.read(eventStateProvider.notifier);
    _eventStateProv.state = const EditState.unprocessed();
    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      _eventStateProv.state = const EditState.processing();
    });
    try {
      await _eventsRepository.addEvent(data: data);
      _eventStateProv.state = const EditState.successful();
    } on CustomException catch (e) {
      _eventStateProv.state = EditState.failed(reason: e.message);
    }
  }

  Future<void> editEvent({
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

    final _eventStateProv = _ref.read(eventStateProvider.notifier);
    _eventStateProv.state = const EditState.unprocessed();
    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      _eventStateProv.state = const EditState.processing();
    });
    try {
      await _eventsRepository.editEvent(data: data);
      _eventStateProv.state = const EditState.successful();
    } on CustomException catch (e) {
      _eventStateProv.state = EditState.failed(reason: e.message);
    }
  }

  Future<String> deleteEvent({
    required String eventId,
  }) async {
    final data = {
      'eventId': eventId,
    };
    return await _eventsRepository.deleteEvent(data: data);
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

  Future<String> addRSVP({
    required String eventId,
    required String userId,
  }) async {
    final data = {
      'eventID': eventId,
      'userID': userId,
    };
    return await _eventsRepository.addRsvp(data: data);
  }

  Future<String> cancelRSVP({
    required String eventId,
    required String userId,
  }) async {
    final data = {
      'eventID': eventId,
      'userID': userId,
    };
    return await _eventsRepository.removeRsvp(data: data);
  }
}
