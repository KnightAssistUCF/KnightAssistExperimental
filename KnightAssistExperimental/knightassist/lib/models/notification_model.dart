import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  NotificationModel._();

  factory NotificationModel({
    required String message,
    required String typeIs,
    required String eventId,
    required String orgId,
    required String orgName,
    // TODO: updateContent
    required bool read,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(JSON json) =>
      _$NotificationModelFromJson(json);
}
