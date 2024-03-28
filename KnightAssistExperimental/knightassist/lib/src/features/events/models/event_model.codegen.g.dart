// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      eventId: json['eventId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      sponsoringOrganization: json['sponsoringOrganization'] as String,
      registeredVolunteers: (json['registeredVolunteers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      checkedInVolunteers: (json['checkedInVolunteers'] as List<dynamic>)
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
      image: json['image'] as String,
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'sponsoringOrganization': instance.sponsoringOrganization,
      'registeredVolunteers': instance.registeredVolunteers,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'checkedInVolunteers': instance.checkedInVolunteers,
      'feedback': instance.feedback,
      'eventTags': instance.eventTags,
      'semester': instance.semester,
      'maxAttendees': instance.maxAttendees,
      'image': instance.image,
    };

_$EventLinksModelImpl _$$EventLinksModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EventLinksModelImpl(
      facebook: json['facebook'] as String,
      twitter: json['twitter'] as String,
      instagram: json['instagram'] as String,
      website: json['website'] as String,
    );

Map<String, dynamic> _$$EventLinksModelImplToJson(
        _$EventLinksModelImpl instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'website': instance.website,
    };

_$CheckedInVolunteerModelImpl _$$CheckedInVolunteerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckedInVolunteerModelImpl(
      volunteerId: json['volunteerId'] as String,
      checkInTime: DateTime.parse(json['checkInTime'] as String),
      checkOutTime: DateTime.parse(json['checkOutTime'] as String),
      wereHoursAdjusted: json['wereHoursAdjusted'] as bool,
    );

Map<String, dynamic> _$$CheckedInVolunteerModelImplToJson(
        _$CheckedInVolunteerModelImpl instance) =>
    <String, dynamic>{
      'volunteerId': instance.volunteerId,
      'checkInTime': instance.checkInTime.toIso8601String(),
      'checkOutTime': instance.checkOutTime.toIso8601String(),
      'wereHoursAdjusted': instance.wereHoursAdjusted,
    };

_$FeedbackModelImpl _$$FeedbackModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedbackModelImpl(
      volunteerId: json['volunteerId'] as String,
      eventId: json['eventId'] as String,
      timeFeedbackSubmitted:
          DateTime.parse(json['timeFeedbackSubmitted'] as String),
      volunteerName: json['volunteerName'] as String,
      volunteerEmail: json['volunteerEmail'] as String,
      eventName: json['eventName'] as String,
      rating: (json['rating'] as num).toDouble(),
      feedbackText: json['feedbackText'] as String,
      wasReadByUser: json['wasReadByUser'] as bool,
    );

Map<String, dynamic> _$$FeedbackModelImplToJson(_$FeedbackModelImpl instance) =>
    <String, dynamic>{
      'volunteerId': instance.volunteerId,
      'eventId': instance.eventId,
      'timeFeedbackSubmitted': instance.timeFeedbackSubmitted.toIso8601String(),
      'volunteerName': instance.volunteerName,
      'volunteerEmail': instance.volunteerEmail,
      'eventName': instance.eventName,
      'rating': instance.rating,
      'feedbackText': instance.feedbackText,
      'wasReadByUser': instance.wasReadByUser,
    };
