import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'event_links_model.freezed.dart';
part 'event_links_model.g.dart';

@freezed
class EventLinksModel with _$EventLinksModel {
  const factory EventLinksModel({
    required String facebook,
    required String twitter,
    required String instagram,
    required String website,
  }) = _EventLinksModel;

  factory EventLinksModel.fromJson(JSON json) =>
      _$EventLinksModelFromJson(json);
}
