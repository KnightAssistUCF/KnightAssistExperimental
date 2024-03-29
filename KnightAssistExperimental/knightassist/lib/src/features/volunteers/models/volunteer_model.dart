import '../../../helpers/typedefs.dart';

class VolunteerModel {
  const VolunteerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.favOrgIds,
    required this.eventRsvpIds,
    required this.eventHistoryIds,
    required this.totalHours,
    required this.semesterHourGoal,
    required this.categoryTags,
    required this.emailValidated,
    required this.firstTimeLogin,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final List<String> favOrgIds;
  final List<String> eventRsvpIds;
  final List<String> eventHistoryIds;
  final num totalHours;
  final num semesterHourGoal;
  final List<String> categoryTags;
  final bool emailValidated;
  final bool firstTimeLogin;

  static VolunteerModel fromJson(JSON json) {
    return VolunteerModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      favOrgIds: (json['favoritedOrganizations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      eventRsvpIds: (json['eventsRSVP'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      eventHistoryIds: (json['eventsHistory'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      totalHours: json['totalVolunteerHours'] as num,
      semesterHourGoal: json['semesterVolunteerHourGoal'] as num,
      categoryTags: (json['categoryTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      emailValidated: json['EmailValidated'] as bool,
      firstTimeLogin: json['firstTimeLogin'] as bool,
    );
  }
}

class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.eventId,
    required this.orgId,
    required this.orgName,
    required this.type,
    required this.message,
    this.content,
    required this.read,
  });

  final String id;
  final String eventId;
  final String orgId;
  final String orgName;
  final String type;
  final String message;
  final NotificationContentModel? content;
  final bool read;

  static NotificationModel fromJson(JSON json) {
    return NotificationModel(
        id: json['_id'] as String,
        eventId: json['eventId'] as String,
        orgId: json['orgId'] as String,
        orgName: json['orgName'] as String,
        type: json['type_is'] as String,
        message: json['message'] as String,
        content: NotificationContentModel.fromJson(
            json['updateContent'] as Map<String, dynamic>),
        read: json['read'] as bool);
  }
}

class NotificationContentModel {
  const NotificationContentModel({
    this.notifId,
    this.orgId,
    this.title,
    this.content,
    this.name,
    this.date,
  });

  final String? notifId;
  final String? orgId;
  final String? title;
  final String? content;
  final String? name;
  final DateTime? date;

  static NotificationContentModel fromJson(JSON json) {
    return NotificationContentModel(
      notifId: json['updateID'] as String,
      orgId: json['organizationID'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
