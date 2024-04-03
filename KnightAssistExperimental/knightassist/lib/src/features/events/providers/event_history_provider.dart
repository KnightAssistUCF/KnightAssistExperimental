import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';
import 'package:knightassist/src/features/events/repositories/event_history_repository.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

final userHistoryProvider =
    FutureProvider.autoDispose<List<EventHistoryModel>>((ref) async {
  final historyProv = ref.watch(eventHistoryProvider);
  return await historyProv.getUserHistory();
});

class EventHistoryProvider {
  final EventHistoryRepository _eventHistoryRepository;
  final Ref _ref;

  EventHistoryProvider({
    required EventHistoryRepository eventsRepository,
    required Ref ref,
  })  : _eventHistoryRepository = eventsRepository,
        _ref = ref,
        super();

  Future<List<EventHistoryModel>> getUserHistory() async {
    final authProv = _ref.watch(authProvider.notifier);
    final queryParams = <String, Object>{
      'studentId': authProv.currentUserId,
    };
    return await _eventHistoryRepository.fetchUserEventHistory(
        queryParameters: queryParams);
  }

  Future<EventHistoryModel> getOneHistory({required String eventId}) async {
    final authProv = _ref.watch(authProvider.notifier);
    final queryParams = <String, Object>{
      'studentId': authProv.currentUserId,
      'eventId': eventId,
    };
    return await _eventHistoryRepository.fetchOneEventHistory(
        queryParameters: queryParams);
  }
}
