import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knightassist/models/checked_in_volunteer_model.dart';

import '../helper/typedefs.dart';
import '../helper/utils/constants.dart';
import 'event_links_model.dart';
import 'feedback_model.dart';
import 's3_bucket_image_model.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  EventModel._();

  factory EventModel({
    @JsonKey(toJson: Constants.toNull, includeIfNull: false)
    required String? eventId,
    required String name,
    required String description,
    required String location,
    required String sponsoringOrganization,
    required List<String> registeredVolunteers,
    required DateTime startTime,
    required DateTime endTime,
    required EventLinksModel eventLinks,
    required List<CheckedInVolunteerModel> checkedInVolunteers,
    required List<FeedbackModel> feedback,
    required List<String> eventTags,
    required String semester,
    required int maxAttendees,
    required S3BucketImageModel image,
  }) = _EventModel;

  factory EventModel.initial() {
    return EventModel(
      eventId: null,
      name: '',
      description: '',
      location: '',
      sponsoringOrganization: '',
      registeredVolunteers: [],
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      eventLinks: const EventLinksModel(
          facebook: '', twitter: '', instagram: '', website: ''),
      checkedInVolunteers: [],
      feedback: [],
      eventTags: [],
      semester: '',
      maxAttendees: 0,
      image: const S3BucketImageModel(type: '', url: '', imageName: ''),
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
