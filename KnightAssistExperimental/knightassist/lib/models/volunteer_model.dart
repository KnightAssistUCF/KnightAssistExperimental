import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'volunteer_model.freezed.dart';
part 'volunteer_model.g.dart';

@freezed
class VolunteerModel with _$VolunteerModel {
  const factory VolunteerModel({
    required String? volunteerId,
    required String firstName,
    required String lastName,
    required String email,
    required List<String> favoritedOrganizations,
    required List<String> eventsRSVP,
    required List<String> eventsHistory,
    required double totalVolunteerHours,
    required double semesterVolunteerHourGoal,
    required List<String> categoryTags,
    required String recoveryToken,
    required String confirmToken,
    required String emailToken,
    required bool emailValidated,
    required bool firstTimeLogin,
    required bool recieveEmails,
  }) = _VolunteerModel;

  factory VolunteerModel.fromJson(JSON json) => _$VolunteerModelFromJson(json);
}
