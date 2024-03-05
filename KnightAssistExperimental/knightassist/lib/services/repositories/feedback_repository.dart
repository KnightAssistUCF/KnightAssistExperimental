import 'package:dio/dio.dart';

import '../../helper/typedefs.dart';
import '../../models/feedback_model.dart';
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

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
      endpoint: ApiEndpoint.feedback(FeedbackEndpoint.FETCH_ORG_FEEDBACK),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => FeedbackModel.fromJson(responseBody),
    );
  }

  Future<String> create({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: ApiEndpoint.feedback(FeedbackEndpoint.ADD_FEEDBACK),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> setRead({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: ApiEndpoint.feedback(FeedbackEndpoint.SET_READ),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
