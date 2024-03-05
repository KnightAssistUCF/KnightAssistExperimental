import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/user_role_enum.dart';
import '../helper/typedefs.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

// IMPORTANT
// Always check user role before attempting to retrieve name!
// Volunteers use firstName and lastName
// Organizations use name

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(includeIfNull: false) required String? userId,
    @JsonKey(includeIfNull: false) String? name,
    @JsonKey(includeIfNull: false) String? firstName,
    @JsonKey(includeIfNull: false) String? lastName,
    required String email,
    required UserRole role,
  }) = _UserModel;

  factory UserModel.fromJson(JSON json) => _$UserModelFromJson(json);
}
