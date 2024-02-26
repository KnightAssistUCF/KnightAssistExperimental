import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'check_in_model.freezed.dart';
part 'check_in_model.g.dart';

@freezed
class CheckInModel with _$CheckInModel {
  const factory CheckInModel({
    required String volunteerId,
    required DateTime checkInTime,
    required DateTime checkOutTime,
    required bool wereHoursAdjusted,
  }) = _CheckInModel;

  factory CheckInModel.fromJson(JSON json) => _$CheckInModelFromJson(json);
}
