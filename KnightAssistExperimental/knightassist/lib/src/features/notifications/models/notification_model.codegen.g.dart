// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      message: json['message'] as String,
      typeIs: json['typeIs'] as String,
      eventId: json['eventId'] as String,
      orgId: json['orgId'] as String,
      orgName: json['orgName'] as String,
      read: json['read'] as bool,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'typeIs': instance.typeIs,
      'eventId': instance.eventId,
      'orgId': instance.orgId,
      'orgName': instance.orgName,
      'read': instance.read,
    };
