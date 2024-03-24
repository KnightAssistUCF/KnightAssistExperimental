import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum UserRole {
  @JsonValue('student')
  VOLUNTEER,
  @JsonValue('organization')
  ORGANIZATION,
}

extension ExtUserRole on UserRole {
  String get toJson => name.toLowerCase();
}
