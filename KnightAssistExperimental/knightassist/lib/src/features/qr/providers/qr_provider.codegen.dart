import '../../../helpers/typedefs.dart';
import '../repositories/qr_repository.codegen.dart';

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
