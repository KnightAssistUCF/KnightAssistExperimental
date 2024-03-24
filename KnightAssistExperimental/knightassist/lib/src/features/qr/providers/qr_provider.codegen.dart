import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/typedefs.dart';
import '../repositories/qr_repository.codegen.dart';

part 'qr_provider.codegen.g.dart';

/// A provider used to access instance of this service
@riverpod
QrProvider qr(QrRef ref) {
  return QrProvider(ref.watch(qrRepositoryProvider));
}

class QrProvider {
  final QrRepository _qrRepository;

  QrProvider(this._qrRepository);

  Future<String> checkIn({required JSON data}) async {
    return _qrRepository.checkIn(data: data);
  }

  Future<String> checkOut({required JSON data}) async {
    return _qrRepository.checkOut(data: data);
  }
}
