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
    return UserModel(
      id: json['_id'],
      email: json['email'],
      role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      orgName: json['name'],
    );
  }
}
