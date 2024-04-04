import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import '../../../core/core.dart';
import '../../../global/states/future_state.codegen.dart';
import '../models/event_model.dart';
import '../repositories/feedback_repository.dart';

// Only call this if user role is org
final orgFeedbackProvider =
    FutureProvider.autoDispose<List<FeedbackModel>>((ref) async {
  final userId = ref.watch(authProvider.notifier).currentUserId;
  final feedbackProv = ref.watch(feedbackProvider);
  return await feedbackProv.getAllForOrg(orgId: userId);
});

final feedbackStateProvider = StateProvider<FutureState<String>>((ref) {
  return const FutureState<String>.idle();
});

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

  Future<void> create({
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
    final feedbackStateProv = _ref.read(feedbackStateProvider.notifier);

    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      feedbackStateProv.state = const FutureState.loading();
    });

    try {
      final temp = await _feedbackRepository.create(data: data);
      feedbackStateProv.state = FutureState<String>.data(data: temp);
    } on CustomException catch (e) {
      feedbackStateProv.state = FutureState.failed(reason: e.message);
    }
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
