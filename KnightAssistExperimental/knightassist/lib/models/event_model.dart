import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/utils/constants.dart';
import '../helper/typedefs.dart';

import 'event_links_model.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  EventModel._();

  factory EventModel({
    // @JSONKey(toJson: Constants.toNull, includeIfNull: false)
    required String? eventId,
    required String name,
    required String description,
    required String location,
    required String sponsoringOrganization,
    required List<String> registeredVolunteers,
    required String profilePicPath,
    required DateTime startTime,
    required DateTime endTime,
    required EventLinksModel eventLinks,
    // TODO: CheckedInStudents
    // TODO: Feedback
    required List<String> eventTags,
    required String semester,
    required int maxAttendees,
    // TODO: Image details
  }) = _EventModel;

  factory EventModel.initial() {
    return EventModel(
      eventId: null,
      name: '',
      description: '',
      location: '',
      sponsoringOrganization: '',
      registeredVolunteers: [],
      profilePicPath: '',
      // TODO: Event links
      // TODO: CheckedInStudents
      // TODO: Feedback
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      eventTags: [],
      semester: '',
      maxAttendees: 0,
      // TODO: Image details
    );
  }

  // TODO: Add event links to update json
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
