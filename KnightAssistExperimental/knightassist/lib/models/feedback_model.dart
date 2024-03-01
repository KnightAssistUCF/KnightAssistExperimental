import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

@freezed
class FeedbackModel with _$FeedbackModel {
  const factory FeedbackModel({
    required String volunteerId,
    required String eventId,
    required DateTime timeFeedbackSubmitted,
    required String volunteerName,
    required String volunteerEmail,
    required String eventName,
    required double rating,
    required String feedbackText,
    required bool wasReadByUser,
  }) = _FeedbackModel;

  factory FeedbackModel.fromJson(JSON json) => _$FeedbackModelFromJson(json);
}
