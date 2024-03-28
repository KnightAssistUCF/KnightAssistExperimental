import '../../../core/core.dart';
import '../../../helpers/typedefs.dart';
import '../enums/qr_endpoint_enum.dart';

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
      converter: (response) =>
          (response['body'] != null) ? response['body']['message'] : response,
    );
  }

  Future<String> checkOut({
    required JSON data,
  }) async {
    return _apiService.setData(
      endpoint: QrEndpoint.CHECK_OUT.route(),
      data: data,
      converter: (response) =>
          (response['body'] != null) ? response['body']['message'] : response,
    );
  }
}
