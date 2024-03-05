import 'package:dio/dio.dart';

import '../../helper/typedefs.dart';
import '../../models/s3_bucket_image_model.dart';
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class ImagesRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  ImagesRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<S3BucketImageModel> fetch({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData(
      endpoint: ApiEndpoint.images(ImageEndpoint.FETCH_IMAGE),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => S3BucketImageModel.fromJson(responseBody),
    );
  }

  Future<S3BucketImageModel> store({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: ApiEndpoint.images(ImageEndpoint.STORE_IMAGE),
      data: data,
      cancelToken: _cancelToken,
      converter: (responseBody) => S3BucketImageModel.fromJson(responseBody),
    );
  }

  Future<S3BucketImageModel> delete({
    required JSON data,
  }) async {
    return await _apiService.deleteData(
      endpoint: ApiEndpoint.images(ImageEndpoint.DELETE_IMAGE),
      data: data,
      cancelToken: _cancelToken,
      converter: (responseBody) => S3BucketImageModel.fromJson(responseBody),
    );
  }
}
