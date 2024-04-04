import 'package:dio/dio.dart';

import '../../../core/core.dart';
import '../../../helpers/typedefs.dart';
import '../enums/organizations_endpoint_enum.dart';
import '../models/organization_model.dart';

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
    final temp = await _apiService.getCollectionData(
      endpoint: OrganizationsEndpoint.FETCH_ALL_ORGANIZATIONS.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (response) => <String, dynamic>{
        'id': response['_id'],
      },
    );
    List<OrganizationModel> orgList = [];
    for (Map<String, dynamic> m in temp) {
      orgList.add(await fetchOrganization(
          queryParameters: {'organizationID': m['id']}));
    }
    return orgList;
  }

  Future<OrganizationModel> fetchOrganization({
    required JSON queryParameters,
  }) async {
    return await _apiService.getDocumentData(
      endpoint: OrganizationsEndpoint.FETCH_ORGANIZATION.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: OrganizationModel.fromJson,
    );
  }

  // Create should be handled by register function

  Future<String> editOrganization({
    required JSON data,
  }) async {
    return await _apiService.setData<String>(
      endpoint: OrganizationsEndpoint.EDIT_ORGANIZATION.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['message'],
    );
  }

  Future<String> deleteOrganization({
    required JSON data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: OrganizationsEndpoint.DELETE_ORGANIZATION.route(),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['message'],
    );
  }

  Future<List<OrganizationModel>> fetchFavoritedOrganizations({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<OrganizationModel>(
      endpoint: OrganizationsEndpoint.FETCH_FAVORITED_ORGS.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: OrganizationModel.fromJson,
    );
  }

  Future<List<OrganizationModel>> fetchSuggestedOrganizations({
    required JSON queryParameters,
  }) async {
    return await _apiService.getCollectionData<OrganizationModel>(
      endpoint: OrganizationsEndpoint.FETCH_SUGGESTED_ORGS.route(),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: OrganizationModel.fromJson,
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}
