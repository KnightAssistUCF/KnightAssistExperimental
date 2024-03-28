// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationModelImpl _$$OrganizationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationModelImpl(
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      logoUrl: json['logoUrl'] as String,
      categoryTags: (json['categoryTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      favorites:
          (json['favorites'] as List<dynamic>).map((e) => e as String).toList(),
      profilePicPath: json['profilePicPath'] as String,
      calendarLink: json['calendarLink'] as String,
      isActive: json['isActive'] as bool,
      eventHappeningNow: json['eventHappeningNow'] as bool,
      backgroundUrl: json['backgroundUrl'] as String,
      events: json['events'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$$OrganizationModelImplToJson(
        _$OrganizationModelImpl instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'logoUrl': instance.logoUrl,
      'categoryTags': instance.categoryTags,
      'favorites': instance.favorites,
      'profilePicPath': instance.profilePicPath,
      'calendarLink': instance.calendarLink,
      'isActive': instance.isActive,
      'eventHappeningNow': instance.eventHappeningNow,
      'backgroundUrl': instance.backgroundUrl,
      'events': instance.events,
      'location': instance.location,
    };
