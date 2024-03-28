// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['_id'] as String?,
      name: json['name'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('name', instance.name);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  val['email'] = instance.email;
  val['role'] = _$UserRoleEnumMap[instance.role]!;
  return val;
}

const _$UserRoleEnumMap = {
  UserRole.VOLUNTEER: 'student',
  UserRole.ORGANIZATION: 'organization',
};
