import 'package:knightassist/src/core/core.dart';
import 'package:knightassist/src/core/networking/api_service.dart';
import 'package:knightassist/src/features/events/enums/event_history_endpoint_enum.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';

import '../../../helpers/typedefs.dart';

class EventHistoryRepository {
  final ApiService _apiService;

  EventHistoryRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<EventHistoryModel>> fetchUserEventHistory({
    required JSON queryParameters,
  }) async {
    return _apiService.getCollectionData<EventHistoryModel>(
      endpoint: EventHistoryEndpoint.FETCH_ALL_HISTORY.route(),
      queryParams: queryParameters,
      converter: EventHistoryModel.fromJson,
    );
  }

  Future<EventHistoryModel> fetchOneEventHistory({
    required JSON queryParameters,
  }) async {
    return _apiService.getDocumentData<EventHistoryModel>(
      endpoint: EventHistoryEndpoint.FETCH_HISTORY.route(),
      queryParams: queryParameters,
      converter: EventHistoryModel.fromJson,
    );
  }
}
