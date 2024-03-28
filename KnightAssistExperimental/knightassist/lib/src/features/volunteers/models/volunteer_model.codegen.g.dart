// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteer_model.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VolunteerModelImpl _$$VolunteerModelImplFromJson(Map<String, dynamic> json) =>
    _$VolunteerModelImpl(
      volunteerId: json['volunteerId'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      favoritedOrganizations: (json['favoritedOrganizations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      eventsRSVP: (json['eventsRSVP'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      eventsHistory: (json['eventsHistory'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      totalVolunteerHours: (json['totalVolunteerHours'] as num).toDouble(),
      semesterVolunteerHourGoal:
          (json['semesterVolunteerHourGoal'] as num).toDouble(),
      categoryTags: (json['categoryTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recoveryToken: json['recoveryToken'] as String,
      confirmToken: json['confirmToken'] as String,
      emailToken: json['emailToken'] as String,
      emailValidated: json['emailValidated'] as bool,
      firstTimeLogin: json['firstTimeLogin'] as bool,
      recieveEmails: json['recieveEmails'] as bool,
    );

Map<String, dynamic> _$$VolunteerModelImplToJson(
        _$VolunteerModelImpl instance) =>
    <String, dynamic>{
      'volunteerId': instance.volunteerId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'favoritedOrganizations': instance.favoritedOrganizations,
      'eventsRSVP': instance.eventsRSVP,
      'eventsHistory': instance.eventsHistory,
      'totalVolunteerHours': instance.totalVolunteerHours,
      'semesterVolunteerHourGoal': instance.semesterVolunteerHourGoal,
      'categoryTags': instance.categoryTags,
      'recoveryToken': instance.recoveryToken,
      'confirmToken': instance.confirmToken,
      'emailToken': instance.emailToken,
      'emailValidated': instance.emailValidated,
      'firstTimeLogin': instance.firstTimeLogin,
      'recieveEmails': instance.recieveEmails,
    };
