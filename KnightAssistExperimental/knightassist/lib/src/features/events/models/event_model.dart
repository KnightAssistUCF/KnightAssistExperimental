// Helpers
import '../../../helpers/typedefs.dart';

class EventModel {
  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.sponsoringOrganizationId,
    required this.registeredVolunteerIds,
    required this.profilePicPath,
    required this.startTime,
    required this.endTime,
    required this.checkedInVolunteers,
    required this.feedback,
    required this.eventTags,
    required this.semester,
    required this.maxAttendees,
    required this.s3ImageId,
  });

  final String id;
  final String name;
  final String description;
  final String location;
  final String sponsoringOrganizationId;
  final List<String> registeredVolunteerIds;
  final String profilePicPath;
  final DateTime startTime;
  final DateTime endTime;
  final List<CheckedInVolunteerModel> checkedInVolunteers;
  final List<FeedbackModel> feedback;
  final List<String> eventTags;
  final String semester;
  final int maxAttendees;
  final String s3ImageId;

  static EventModel fromJson(JSON json) {
    return EventModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      sponsoringOrganizationId: json['sponsoringOrganization'] as String,
      registeredVolunteerIds: (json['registeredVolunteers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      profilePicPath: json['profilePicPath'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      checkedInVolunteers: (json['checkedInStudents'] as List<dynamic>)
          .map((e) =>
              CheckedInVolunteerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      feedback: (json['feedback'] as List<dynamic>)
          .map((e) => FeedbackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventTags:
          (json['eventTags'] as List<dynamic>).map((e) => e as String).toList(),
      semester: json['semester'] as String,
      maxAttendees: json['maxAttendees'] as int,
      s3ImageId: json['S3BucketImageDetails'] as String,
    );
  }
}

class CheckedInVolunteerModel {
  CheckedInVolunteerModel({
    required this.id,
    required this.studentId,
    required this.checkInTime,
    required this.checkOutTime,
    required this.wereHoursAdjusted,
  });

  final String id;
  final String studentId;
  final DateTime checkInTime;
  final DateTime checkOutTime;
  final bool wereHoursAdjusted;

  static CheckedInVolunteerModel fromJson(JSON json) {
    return CheckedInVolunteerModel(
        id: json['_id'] as String,
        studentId: json['studentId'] as String,
        checkInTime: DateTime.parse(json['checkInTime'] as String),
        checkOutTime: DateTime.parse(json['checkOutTime'] as String),
        wereHoursAdjusted:
            json['wereHoursAdjusted_ForSudent_ForThisEvent'] as bool);
  }
}

class FeedbackModel {
  FeedbackModel({
    required this.id,
    required this.volunteerId,
    required this.eventId,
    required this.volunteerName,
    required this.volunteerEmail,
    required this.eventName,
    required this.rating,
    required this.content,
    required this.wasReadByUser,
    required this.timeSubmitted,
  });
  final String id;
  final String volunteerId;
  final String eventId;
  final String volunteerName;
  final String volunteerEmail;
  final String eventName;
  final num rating;
  final String content;
  final bool wasReadByUser;
  final DateTime timeSubmitted;

  static FeedbackModel fromJson(JSON json) {
    return FeedbackModel(
      id: json['_id'] as String,
      volunteerId: json['studentId'] as String,
      eventId: json['eventId'] as String,
      volunteerName: json['studentName'] as String,
      volunteerEmail: json['studentEmail'] as String,
      eventName: json['eventName'] as String,
      rating: json['rating'] as num,
      content: json['feedbackText'] as String,
      wasReadByUser: json['wasReadByUser'] as bool,
      timeSubmitted: DateTime.parse(json['timeFeedbackSubmitted'] as String),
    );
  }
}
