import '../../../helpers/typedefs.dart';

class VolunteerModel {
  VolunteerModel({
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
    this.profilePicPath,
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
  String? profilePicPath;

  static VolunteerModel fromJson(JSON json) {
    return VolunteerModel(
      id: json['_id'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      favOrgIds: (json['favoritedOrganizations'] != null)
          ? (json['favoritedOrganizations'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
      eventRsvpIds: (json['eventsRsvp'] != null)
          ? (json['eventsRSVP'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
      eventHistoryIds: (json['eventsHistory'] != null)
          ? (json['eventsHistory'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
      totalHours: json['totalVolunteerHours'] as num? ?? 0,
      semesterHourGoal: json['semesterVolunteerHourGoal'] as num? ?? 0,
      categoryTags: (json['categoryTags'] != null)
          ? (json['categoryTags'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
      emailValidated: json['EmailValidated'] as bool? ?? false,
      firstTimeLogin: json['firstTimeLogin'] as bool? ?? false,
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
    required this.read,
    required this.content,
  });

  final String id;
  final String eventId;
  final String orgId;
  final String orgName;
  final String type;
  final String message;
  final bool read;
  final NotificationContentModel? content;

  static NotificationModel fromJson(JSON json) {
    return NotificationModel(
      id: json['_id'] as String,
      eventId: json['eventId'] as String? ?? '',
      orgId: json['orgId'] as String? ?? '',
      orgName: json['orgName'] as String? ?? '',
      type: json['type_is'] as String? ?? '',
      message: json['message'] as String? ?? '',
      read: json['read'] as bool? ?? false,
      content: (json['updateContent'] != null)
          ? NotificationContentModel.fromJson(
              json['updateContent'] as Map<String, dynamic>)
          : NotificationContentModel(
              notifId: '',
              orgId: '',
              title: '',
              content: '',
              name: '',
              date: DateTime.now()),
    );
  }
}

class NotificationContentModel {
  const NotificationContentModel({
    required this.notifId,
    required this.orgId,
    required this.title,
    required this.content,
    required this.name,
    required this.date,
  });

  final String notifId;
  final String orgId;
  final String title;
  final String content;
  final String name;
  final DateTime date;

  static NotificationContentModel fromJson(JSON json) {
    return NotificationContentModel(
      notifId: json['updateID'] as String? ?? '',
      orgId: json['organizationID'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      name: json['name'] as String? ?? '',
      date: (json['date'] != null)
          ? DateTime.parse(json['date'] as String)
          : DateTime.now(),
    );
  }
}
