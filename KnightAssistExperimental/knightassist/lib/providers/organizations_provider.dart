import '../models/organization_model.dart';
import '../services/repositories/organizations_repository.dart';

class OrganizationsProvider {
  final OrganizationsRepository _organizationsRepository;

  OrganizationsProvider(this._organizationsRepository);

  Future<List<OrganizationModel>> getAllOrgs() async {
    return await _organizationsRepository.fetchAll();
  }

  Future<OrganizationModel> getOrgById({required String orgId}) async {
    final queryParams = {
      'orgId': orgId,
    };
    return await _organizationsRepository.fetchOne(
        queryParameters: queryParams);
  }

  // TODO: Finish update org function
  Future<String> editOrg({
    required OrganizationModel org,
    String? name,
    String? email,
    String? password,
    String? description,
    String? logoUrl,
  }) async {
    final data = org.toUpdateJson(
      name: name,
      email: email,
      password: password,
      description: description,
      logoUrl: logoUrl,
    );
    if (data.isEmpty) return "nothing to update";
    return await _organizationsRepository.update(data: data);
  }

  Future<String> deleteOrg({
    required String orgId,
  }) async {
    final data = {
      'orgId': orgId,
    };
    return await _organizationsRepository.delete(data: data);
  }

  Future<List<OrganizationModel>> getFavoritedOrgs({
    required String userId,
  }) async {
    final queryParams = {
      'userId': userId,
    };
    return await _organizationsRepository.fetchFavorited(
        queryParameters: queryParams);
  }

  Future<List<OrganizationModel>> getSuggestedOrgs({
    required String userId,
  }) async {
    final queryParams = {
      'userId': userId,
    };
    return await _organizationsRepository.fetchSuggested(
        queryParameters: queryParams);
  }
}
