import '../models/feedback_model.dart';
import '../services/repositories/feedback_repository.dart';

class FeedbackProvider {
  final FeedbackRepository _feedbackRepository;
  FeedbackProvider(this._feedbackRepository);

  Future<List<FeedbackModel>> getAllForOrg({
    required String orgId,
  }) async {
    final queryParams = {
      'orgId': orgId,
    };
    return await _feedbackRepository.fetchAllForOrg(
        queryParameters: queryParams);
  }

  Future<String> create({
    required String userId,
    required String eventId,
    required double rating,
    required String feedbackText,
  }) async {
    final feedback = FeedbackModel(
      volunteerId: userId,
      eventId: eventId,
      timeFeedbackSubmitted: DateTime.now(),
      volunteerName: '',
      volunteerEmail: '',
      eventName: '',
      rating: rating,
      feedbackText: feedbackText,
      wasReadByUser: false,
    );

    final data = <String, Object?>{
      ...feedback.toJson(),
    };
    return await _feedbackRepository.create(data: data);
  }

  Future<String> setRead({
    required String eventId,
    required String feedbackId,
  }) async {
    final data = {
      'eventId': eventId,
      'feedbackId': feedbackId,
    };
    return await _feedbackRepository.setRead(data: data);
  }
}
