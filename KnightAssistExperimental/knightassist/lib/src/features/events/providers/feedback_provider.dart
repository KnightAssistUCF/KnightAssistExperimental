import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

import '../models/event_model.dart';
import '../repositories/feedback_repository.dart';

class FeedbackProvider {
  final FeedbackRepository _feedbackRepository;
  final Ref _ref;

  FeedbackProvider({
    required FeedbackRepository feedbackRepository,
    required Ref ref,
  })  : _feedbackRepository = feedbackRepository,
        _ref = ref,
        super();

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
    required String eventId,
    required double rating,
    required String content,
  }) async {
    final authProv = _ref.watch(authProvider.notifier);
    final data = <String, dynamic>{
      'eventID': eventId,
      'studentID': authProv.currentUserId,
      'rating': rating,
      'feedbackText': content,
    };
    return await _feedbackRepository.create(data: data);
  }

  Future<String> markAsRead({
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
