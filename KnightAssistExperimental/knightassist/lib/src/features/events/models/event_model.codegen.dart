import 'package:freezed_annotation/freezed_annotation.dart';

// Helpers
import '../../../helpers/typedefs.dart';

// Enums
part 'event_model.codegen.freezed.dart';
part 'event_model.codegen.g.dart';

@freezed
class EventModel with _$EventModel {
  EventModel._();

  factory EventModel({
    required String eventId,
    required String name,
    required String description,
    required String location,
    required String sponsoringOrganization,
    required List<String> registeredVolunteers,
    required DateTime startTime,
    required DateTime endTime,
    required List<CheckedInVolunteerModel> checkedInVolunteers,
    required List<FeedbackModel> feedback,
    required List<String> eventTags,
    required String semester,
    required int maxAttendees,
    required String image,
  }) = _EventModel;

  factory EventModel.initial() {
    return EventModel(
      eventId: '',
      name: '',
      description: '',
      location: '',
      sponsoringOrganization: '',
      registeredVolunteers: [],
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      checkedInVolunteers: [],
      feedback: [],
      eventTags: [],
      semester: '',
      maxAttendees: 0,
      image: '',
    );
  }

  // TODO: Add event links and image to update json
  JSON toUpdateJson({
    String? name,
    String? description,
    String? location,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? eventTags,
    String? semester,
    int? maxAttendees,
  }) {
    if (name == null &&
        description == null &&
        location == null &&
        startTime == null &&
        endTime == null &&
        eventTags == null &&
        semester == null &&
        maxAttendees == null) return const <String, Object>{};
    return copyWith(
      eventId: eventId,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      eventTags: eventTags ?? this.eventTags,
      semester: semester ?? this.semester,
      maxAttendees: maxAttendees ?? this.maxAttendees,
    ).toJson();
  }

  factory EventModel.fromJson(JSON json) => _$EventModelFromJson(json);
}

@freezed
class EventLinksModel with _$EventLinksModel {
  const factory EventLinksModel({
    required String facebook,
    required String twitter,
    required String instagram,
    required String website,
  }) = _EventLinksModel;

  factory EventLinksModel.fromJson(JSON json) =>
      _$EventLinksModelFromJson(json);
}

@freezed
class CheckedInVolunteerModel with _$CheckedInVolunteerModel {
  const factory CheckedInVolunteerModel({
    required String volunteerId,
    required DateTime checkInTime,
    required DateTime checkOutTime,
    required bool wereHoursAdjusted,
  }) = _CheckedInVolunteerModel;

  factory CheckedInVolunteerModel.fromJson(JSON json) =>
      _$CheckedInVolunteerModelFromJson(json);
}

@freezed
class FeedbackModel with _$FeedbackModel {
  const factory FeedbackModel({
    required String volunteerId,
    required String eventId,
    required DateTime timeFeedbackSubmitted,
    required String volunteerName,
    required String volunteerEmail,
    required String eventName,
    required double rating,
    required String feedbackText,
    required bool wasReadByUser,
  }) = _FeedbackModel;

  factory FeedbackModel.fromJson(JSON json) => _$FeedbackModelFromJson(json);
}
