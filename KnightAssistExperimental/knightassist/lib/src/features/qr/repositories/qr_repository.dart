import 'package:knightassist/src/features/events/models/event_model.dart';

import '../../../core/core.dart';
import '../../../helpers/typedefs.dart';
import '../enums/qr_endpoint_enum.dart';

class QrRepository {
  final ApiService _apiService;

  QrRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<dynamic> checkIn({
    required JSON data,
  }) async {
    return _apiService.setData(
      endpoint: QrEndpoint.CHECK_IN.route(),
      data: data,
      converter: (response) => (response['eventObj'] != null)
          ? EventModel.fromJson(response['eventObj'])
          : response,
    );
  }

  Future<dynamic> checkOut({
    required JSON data,
  }) async {
    return _apiService.setData(
      endpoint: QrEndpoint.CHECK_OUT.route(),
      data: data,
      converter: (response) => (response['eventObj'] != null)
          ? EventModel.fromJson(response['eventObj'])
          : response,
    );
  }
}
