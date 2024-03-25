import 'package:dio/dio.dart';
import 'package:knightassist/src/features/images/enums/images_endpoint_enum.dart';

import '../../../core/core.dart';
import '../../../helpers/typedefs.dart';
import '../models/s3_bucket_image_model.codegen.dart';

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
      endpoint: ImagesEndpoint.FETCH_IMAGE.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => S3BucketImageModel.fromJson(responseBody),
    );
  }

  Future<String> store({
    required JSON data,
  }) async {
    return await _apiService.setData(
      endpoint: ImagesEndpoint.STORE_IMAGE.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'],
    );
  }

  Future<String> delete({
    required JSON data,
  }) async {
    return await _apiService.deleteData(
      endpoint: ImagesEndpoint.DELETE_IMAGE.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'],
    );
  }
}
