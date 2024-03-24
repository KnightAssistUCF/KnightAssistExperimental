// Helpers
import 'package:dio/dio.dart';

import '../../helpers/constants/app_utils.dart';
import '../../helpers/typedefs.dart';

class ResponseModel<T> {
  final _ResponseHeadersModel headers;
  final T body;

  const ResponseModel({
    required this.headers,
    required this.body,
  });

  factory ResponseModel.fromJson(Response<JSON> response) {
    return ResponseModel(
      headers: _ResponseHeadersModel.fromJson(
        response.headers.map as JSON,
      ),
      body: response.data! as T,
    );
  }
}

class _ResponseHeadersModel {
  final bool error;
  final String message;
  final String? code;

  const _ResponseHeadersModel({
    required this.error,
    required this.message,
    this.code,
  });

  factory _ResponseHeadersModel.fromJson(JSON json) {
    return _ResponseHeadersModel(
      error: (json['error'] != null)
          ? AppUtils.boolFromInt(json['error'] as int)
          : false,
      message: (json['message'] != null) ? json['message'] as String : '',
      code: json['code'] as String?,
    );
  }
}
