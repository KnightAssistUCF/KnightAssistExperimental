import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/typedefs.dart';
import '../enums/user_role_enum.dart';

// IMPORTANT
// Always check user role before attempting to retrieve name!
// Volunteers use firstName and lastName
// Organizations use name

class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.role,
    this.firstName,
    this.lastName,
    this.orgName,
  });

  final String id;
  final String email;
  final UserRole role;
  final String? firstName;
  final String? lastName;
  final String? orgName;

  static UserModel fromJson(JSON json) {
    print(json);
    return UserModel(
      id: json['_id'] as String,
      email: json['email'] as String,
      role: $enumDecode(userRoleEnumMap, json['role']),
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      orgName: json['name'] as String? ?? '',
    );
  }

  static final userRoleEnumMap = {
    UserRole.VOLUNTEER: 'student',
    UserRole.ORGANIZATION: 'organization',
  };
}
