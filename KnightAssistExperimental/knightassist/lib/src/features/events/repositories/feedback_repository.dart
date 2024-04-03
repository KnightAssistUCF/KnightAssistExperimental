import 'package:dio/dio.dart';

import '../../../core/core.dart';
import '../../../helpers/typedefs.dart';
import '../enums/feedback_endpoint_enum.dart';
import '../models/event_model.dart';

class FeedbackRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  FeedbackRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<FeedbackModel>> fetchAllForOrg({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<FeedbackModel>(
      endpoint: FeedbackEndpoint.FETCH_ORG_FEEDBACK.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: FeedbackModel.fromJson,
    );
  }

  Future<String> create({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: FeedbackEndpoint.ADD_FEEDBACK.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response as String,
    );
  }

  Future<String> setRead({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: FeedbackEndpoint.SET_READ.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response as String,
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
