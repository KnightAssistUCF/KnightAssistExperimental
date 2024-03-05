import 'package:dio/dio.dart';

import '../../helper/typedefs.dart';
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class QrRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  QrRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<String> checkIn({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: ApiEndpoint.qr(QREndpoint.CHECK_IN),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> checkOut({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: ApiEndpoint.qr(QREndpoint.CHECK_OUT),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }
}
