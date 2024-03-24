import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/core.dart';
import '../../../helpers/typedefs.dart';
import '../enums/qr_endpoint_enum.dart';

part 'qr_repository.codegen.g.dart';

/// A provider used to access instance of this service
@riverpod
QrRepository qrRepository(QrRepositoryRef ref) {
  final _apiService = ref.watch(apiServiceProvider);
  return QrRepository(apiService: _apiService);
}

class QrRepository {
  final ApiService _apiService;

  QrRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<String> checkIn({
    required JSON data,
  }) async {
    return _apiService.setData(
      endpoint: QrEndpoint.CHECK_IN.route(),
      data: data,
      converter: (response) => response.body['message'],
    );
  }

  Future<String> checkOut({
    required JSON data,
  }) async {
    return _apiService.setData(
      endpoint: QrEndpoint.CHECK_OUT.route(),
      data: data,
      converter: (response) => response.body['message'],
    );
  }
}
