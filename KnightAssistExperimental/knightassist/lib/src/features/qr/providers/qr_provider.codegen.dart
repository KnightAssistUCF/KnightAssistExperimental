import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';

import '../repositories/qr_repository.codegen.dart';

final qrStateProvider = StateProvider<FutureState<String>>((ref) {
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

  Future<String> checkIn({required String eventId}) async {
    final authProv = _ref.watch(authProvider.notifier);
    final data = <String, Object>{
      'studentId': authProv.currentUserId,
      'qrCodeData_eventID': eventId,
    };
    return _qrRepository.checkIn(data: data);
  }

  Future<String> checkOut({required String eventId}) async {
    final authProv = _ref.watch(authProvider.notifier);
    final data = <String, Object>{
      'studentId': authProv.currentUserId,
      'qrCodeData_eventID': eventId,
    };
    return _qrRepository.checkOut(data: data);
  }
}
