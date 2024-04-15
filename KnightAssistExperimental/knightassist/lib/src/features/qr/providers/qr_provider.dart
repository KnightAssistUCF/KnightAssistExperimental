import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/core/core.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';

import '../repositories/qr_repository.dart';

final qrStateProvider = StateProvider<FutureState<dynamic>>((ref) {
  return const FutureState.idle();
});

class QrProvider {
  final QrRepository _qrRepository;
  final Ref _ref;

  QrProvider({
    required QrRepository qrRepository,
    required Ref ref,
  })  : _qrRepository = qrRepository,
        _ref = ref,
        super();

  Future<void> checkIn({required String eventId}) async {
    final authProv = _ref.watch(authProvider.notifier);
    final data = <String, Object>{
      'studentId': authProv.currentUserId,
      'qrCodeData_eventID': eventId,
    };

    final qrStateProv = _ref.read(qrStateProvider.notifier);
    qrStateProv.state = const FutureState.idle();

    await Future<void>.delayed(const Duration(milliseconds: 100)).then((_) {
      qrStateProv.state = const FutureState.loading();
    });

    try {
      final response = await _qrRepository.checkIn(data: data);
      qrStateProv.state = FutureState<dynamic>.data(data: response);
    } on CustomException catch (e) {
      qrStateProv.state = FutureState.failed(reason: e.message);
    }
  }

  Future<void> checkOut({required String eventId}) async {
    final authProv = _ref.watch(authProvider.notifier);
    final data = <String, Object>{
      'studentId': authProv.currentUserId,
      'qrCodeData_eventID_WithHash': eventId,
    };

    final qrStateProv = _ref.read(qrStateProvider.notifier);
    qrStateProv.state = const FutureState.idle();

    await Future<void>.delayed(const Duration(milliseconds: 100)).then((_) {
      qrStateProv.state = const FutureState.loading();
    });

    try {
      final response = await _qrRepository.checkOut(data: data);
      qrStateProv.state = FutureState<dynamic>.data(data: response);
    } on CustomException catch (e) {
      qrStateProv.state = FutureState.failed(reason: e.message);
    }
  }
}
