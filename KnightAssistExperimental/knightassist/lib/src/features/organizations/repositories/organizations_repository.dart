import 'package:dio/dio.dart';

import '../../../core/core.dart';
import '../../../helpers/typedefs.dart';
import '../enums/organizations_endpoint_enum.dart';
import '../models/organization_model.codegen.dart';

class OrganizationsRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  OrganizationsRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<OrganizationModel>> fetchAllOrganizations({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData<OrganizationModel>(
      endpoint: OrganizationsEndpoint.FETCH_ALL_ORGANIZATIONS.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => OrganizationModel.fromJson(responseBody),
    );
  }

  Future<OrganizationModel> fetchOrganization({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData<OrganizationModel>(
      endpoint: OrganizationsEndpoint.FETCH_ORGANIZATION.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => OrganizationModel.fromJson(responseBody),
    );
  }

  // Create should be handled by register function

  Future<String> editOrganization({
    required JSON data,
  }) async {
    return await _apiService.updateData<String>(
      endpoint: OrganizationsEndpoint.EDIT_ORGANIZATION.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'],
    );
  }

  Future<String> deleteOrganization({
    required JSON data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: OrganizationsEndpoint.DELETE_ORGANIZATION.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'],
    );
  }

  Future<List<OrganizationModel>> fetchFavoritedOrganizations({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<OrganizationModel>(
      endpoint: OrganizationsEndpoint.FETCH_FAVORITED_ORGS.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => OrganizationModel.fromJson(responseBody),
    );
  }

  Future<List<OrganizationModel>> fetchSuggestedOrganizations({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<OrganizationModel>(
      endpoint: OrganizationsEndpoint.FETCH_SUGGESTED_ORGS.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => OrganizationModel.fromJson(responseBody),
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
