import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/typedefs.dart';
import '../enums/user_role_enum.dart';

part 'user_model.codegen.freezed.dart';
part 'user_model.codegen.g.dart';

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
