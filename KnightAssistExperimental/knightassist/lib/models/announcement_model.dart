import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'announcement_model.freezed.dart';
part 'announcement_model.g.dart';

@freezed
class AnnouncementModel with _$AnnouncementModel {
  AnnouncementModel._();

  factory AnnouncementModel({
    required String title,
    required String content,
    required DateTime date,
  }) = _AnnouncementModel;

  factory AnnouncementModel.initial() {
    return AnnouncementModel(
      title: '',
      content: '',
      date: DateTime.now(),
    );
  }

  factory AnnouncementModel.fromJson(JSON json) =>
      _$AnnouncementModelFromJson(json);
}
