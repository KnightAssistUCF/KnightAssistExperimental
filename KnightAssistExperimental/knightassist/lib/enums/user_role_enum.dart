import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum UserRole {
  @JsonValue('volunteer')
  VOLUNTEER,
  @JsonValue('organization')
  ORGANIZATION,
}

extension ExtUserRole on UserRole {
  String get toJson => name.toLowerCase();
}
