import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'checked_in_volunteer_model.freezed.dart';
part 'checked_in_volunteer_model.g.dart';

@freezed
class CheckedInVolunteerModel with _$CheckedInVolunteerModel {
  const factory CheckedInVolunteerModel({
    required String volunteerId,
    required DateTime checkInTime,
    required DateTime checkOutTime,
    required bool wereHoursAdjusted,
  }) = _CheckedInVolunteerModel;

  factory CheckedInVolunteerModel.fromJson(JSON json) =>
      _$CheckedInVolunteerModelFromJson(json);
}
