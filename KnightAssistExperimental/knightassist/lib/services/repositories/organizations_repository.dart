import 'package:dio/dio.dart';

import '../../helper/typedefs.dart';
import '../../models/organization_model.dart';
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class OrganizationsRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  OrganizationsRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<OrganizationModel>> fetchAll({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData<OrganizationModel>(
      endpoint: ApiEndpoint.organizations(
          OrganizationEndpoint.FETCH_ALL_ORGANIZATIONS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => OrganizationModel.fromJson(responseBody),
    );
  }

  Future<OrganizationModel> fetchOne({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData<OrganizationModel>(
      endpoint:
          ApiEndpoint.organizations(OrganizationEndpoint.FETCH_ORGANIZATION),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => OrganizationModel.fromJson(responseBody),
    );
  }

  // Create should be handled by register function

  Future<String> update({
    required JSON data,
  }) async {
    return await _apiService.updateData<String>(
      endpoint:
          ApiEndpoint.organizations(OrganizationEndpoint.EDIT_ORGANIZATION),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> delete({
    required String orgId,
    JSON? data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint:
          ApiEndpoint.organizations(OrganizationEndpoint.DELETE_ORGANIZATION),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<List<OrganizationModel>> fetchFavorited({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<OrganizationModel>(
      endpoint:
          ApiEndpoint.organizations(OrganizationEndpoint.FETCH_FAVORITED_ORGS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => OrganizationModel.fromJson(responseBody),
    );
  }

  Future<List<OrganizationModel>> fetchSuggested({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<OrganizationModel>(
      endpoint:
          ApiEndpoint.organizations(OrganizationEndpoint.FETCH_SUGGESTED_ORGS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => OrganizationModel.fromJson(responseBody),
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
