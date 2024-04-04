import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';

// Models
import '../../../core/networking/custom_exception.dart';
import '../../../global/states/edit_state.codegen.dart';
import '../models/event_model.dart';

// Repositories
import '../repositories/events_repository.dart';

final allEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  return await ref.watch(eventsProvider).getAllEvents();
});

// Only call this if user role is org
final orgEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  final userId = ref.watch(authProvider.notifier).currentUserId;
  return await ref.watch(eventsProvider).getOrgEvents(orgId: userId);
});

// Only call these if user role is volunteer
final suggestedEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  return await ref.watch(eventsProvider).getSuggestedEvents();
});

final favOrgEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  return await ref.watch(eventsProvider).getFavoritedOrgEvents();
});

final rsvpedEventsProvider =
    FutureProvider.autoDispose<List<EventModel>>((ref) async {
  return await ref.watch(eventsProvider).getRsvpedEvents();
});

final eventStateProvider = StateProvider<EditState>((ref) {
  return const EditState.unprocessed();
});

final rsvpStateProvider = StateProvider<FutureState<String>>((ref) {
  return const FutureState<String>.idle();
});

final currentEventProvider = StateProvider<EventModel?>((ref) {
  return EventModel(
    id: '',
    name: '',
    description: '',
    location: '',
    sponsoringOrganizationId: '',
    registeredVolunteerIds: [],
    profilePicPath: '',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    checkedInVolunteers: [],
    feedback: [],
    eventTags: [],
    semester: '',
    maxAttendees: 1,
    s3ImageId: '',
  );
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
    final imgProv = _ref.watch(imagesProvider);
    List<EventModel> temp =
        await _eventsRepository.fetchAllEvents(queryParameters: queryParams);
    for (EventModel e in temp) {
      e.profilePicPath = await imgProv.retrieveImage(type: '1', id: e.id);
    }
    if (searchTerm != null) {
      temp =
          temp.where((element) => element.name.contains(searchTerm)).toList();
    }
    return temp;
  }

  Future<EventModel> getEventById({
    required String eventId,
  }) async {
    final queryParams = {
      'eventID': eventId,
    };
    final imgProv = _ref.watch(imagesProvider);
    final temp =
        await _eventsRepository.fetchEvent(queryParameters: queryParams);
    temp.profilePicPath = await imgProv.retrieveImage(type: '1', id: temp.id);
    return temp;
  }

  Future<void> createEvent({
    required String name,
    required String description,
    required String location,
    required String sponsoringOrganization,
    required String profilePicPath,
    required DateTime startTime,
    required DateTime endTime,
    required List<String> eventTags,
    required int maxAttendees,
  }) async {
    final data = <String, dynamic>{
      'name': name,
      'description': description,
      'location': location,
      'sponsoringOrganization': sponsoringOrganization,
      'profilePicPath': profilePicPath,
      'startTime': startTime,
      'endTime': endTime,
      'eventTags': eventTags,
      'maxAttendees': maxAttendees,
    };

    final eventStateProv = _ref.read(eventStateProvider.notifier);
    eventStateProv.state = const EditState.unprocessed();

    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      eventStateProv.state = const EditState.processing();
    });

    try {
      await _eventsRepository.addEvent(data: data);
      eventStateProv.state = const EditState.successful();
    } on CustomException catch (e) {
      eventStateProv.state = EditState.failed(reason: e.message);
    }
  }

  Future<void> editEvent({
    required String eventId,
    required String orgId,
    String? name,
    String? description,
    String? location,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? eventTags,
    String? semester,
    int? maxAttendees,
  }) async {
    final data = <String, dynamic>{
      'eventID': eventId,
      'organizationID': orgId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (eventTags != null) 'eventTags': eventTags,
      if (semester != null) 'semester': semester,
      if (maxAttendees != null) 'maxAttendees': maxAttendees,
    };

    final eventStateProv = _ref.read(eventStateProvider.notifier);
    eventStateProv.state = const EditState.unprocessed();

    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      eventStateProv.state = const EditState.processing();
    });
    try {
      await _eventsRepository.editEvent(data: data);
      eventStateProv.state = const EditState.successful();
    } on CustomException catch (e) {
      eventStateProv.state = EditState.failed(reason: e.message);
    }
  }

  Future<String> deleteEvent({
    required String eventId,
    required String orgId,
  }) async {
    final data = <String, dynamic>{
      'eventID': eventId,
      'organizationID': orgId,
    };
    return await _eventsRepository.deleteEvent(data: data);
  }

  Future<List<EventModel>> getOrgEvents(
      {required String orgId, String? searchTerm}) async {
    final queryParams = {
      'organizationID': orgId,
    };

    final imgProv = _ref.watch(imagesProvider);
    List<EventModel> temp =
        await _eventsRepository.fetchOrgEvents(queryParameters: queryParams);
    for (EventModel e in temp) {
      e.profilePicPath = await imgProv.retrieveImage(type: '1', id: e.id);
    }
    if (searchTerm != null) {
      temp =
          temp.where((element) => element.name.contains(searchTerm)).toList();
    }
    return temp;
  }

  Future<List<EventModel>> getRsvpedEvents() async {
    final authProv = _ref.watch(authProvider.notifier);
    final queryParams = {
      'studentID ': authProv.currentUserId,
    };
    final imgProv = _ref.watch(imagesProvider);
    final temp =
        await _eventsRepository.fetchRsvpedEvents(queryParameters: queryParams);
    for (EventModel e in temp) {
      e.profilePicPath = await imgProv.retrieveImage(type: '1', id: e.id);
    }
    return temp;
  }

  Future<List<EventModel>> getFavoritedOrgEvents() async {
    final authProv = _ref.watch(authProvider.notifier);
    final queryParams = {
      'userID ': authProv.currentUserId,
    };
    final imgProv = _ref.watch(imagesProvider);
    final temp = await _eventsRepository.fetchFavoritedOrgsEvents(
        queryParameters: queryParams);
    for (EventModel e in temp) {
      e.profilePicPath = await imgProv.retrieveImage(type: '1', id: e.id);
    }
    return temp;
  }

  Future<List<EventModel>> getSuggestedEvents() async {
    final authProv = _ref.watch(authProvider.notifier);
    final queryParams = {
      'userID': authProv.currentUserId,
    };
    final imgProv = _ref.watch(imagesProvider);
    final temp = await _eventsRepository.fetchSuggestedEvents(
        queryParameters: queryParams);
    for (EventModel e in temp) {
      e.profilePicPath = await imgProv.retrieveImage(type: '1', id: e.id);
    }
    return temp;
  }

  // TODO: Ask backend what check var is in relation to RSVPs

  Future<void> addRSVP({
    required String eventId,
    required String eventName,
  }) async {
    final authProv = _ref.watch(authProvider.notifier);
    final data = {
      'eventID': eventId,
      'eventName': eventName,
      'userID': authProv.currentUserId,
    };

    final rsvpStateProv = _ref.read(rsvpStateProvider.notifier);
    rsvpStateProv.state = const FutureState.idle();

    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      rsvpStateProv.state = const FutureState.loading();
    });

    try {
      final response = await _eventsRepository.addRsvp(data: data);
      rsvpStateProv.state = FutureState<String>.data(data: response);
    } on CustomException catch (e) {
      rsvpStateProv.state = FutureState.failed(reason: e.message);
    }
  }

  Future<void> cancelRSVP({
    required String eventId,
    required String eventName,
  }) async {
    final authProv = _ref.watch(authProvider.notifier);
    final data = {
      'eventID': eventId,
      'eventName': eventName,
      'userID': authProv.currentUserId,
    };
    final rsvpStateProv = _ref.read(rsvpStateProvider.notifier);
    rsvpStateProv.state = const FutureState.idle();

    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      rsvpStateProv.state = const FutureState.loading();
    });

    try {
      final response = await _eventsRepository.removeRsvp(data: data);
      rsvpStateProv.state = FutureState<String>.data(data: response);
    } on CustomException catch (e) {
      rsvpStateProv.state = FutureState.failed(reason: e.message);
    }
  }
}
