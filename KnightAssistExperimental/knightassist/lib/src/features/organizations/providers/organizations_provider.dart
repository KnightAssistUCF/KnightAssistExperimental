import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/providers/events_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

import '../../../global/states/edit_state.codegen.dart';
import '../models/organization_model.dart';
import '../repositories/organizations_repository.dart';

final allOrgsProvider =
    FutureProvider.autoDispose<List<OrganizationModel>>((ref) async {
  final _orgsProvider = ref.watch(organizationsProvider);
  return await _orgsProvider.getAllOrgs();
});

final eventOrgProvider =
    FutureProvider.autoDispose<OrganizationModel>((ref) async {
  final _currentEvent = ref.watch(currentEventProvider);
  final _orgsProvider = ref.watch(organizationsProvider);

  return await _orgsProvider.getOrgById(
      orgId: _currentEvent!.sponsoringOrganizationId);
});

// Only call these if user role is volunteer
final favOrgsProvider =
    FutureProvider.autoDispose<List<OrganizationModel>>((ref) async {
  final _userId = ref.watch(authProvider.notifier).currentUserId;
  final _orgsProvider = ref.watch(organizationsProvider);
  return await _orgsProvider.getFavoritedOrgs(userId: _userId);
});

final suggestedOrgsProvider =
    FutureProvider.autoDispose<List<OrganizationModel>>((ref) async {
  final _userId = ref.watch(authProvider.notifier).currentUserId;
  final _orgsProvider = ref.watch(organizationsProvider);
  return await _orgsProvider.getSuggestedOrgs(userId: _userId);
});

final organizationStateProvider = StateProvider<EditState>((ref) {
  return const EditState.unprocessed();
});

final currentOrganizationProvider =
    StateProvider<OrganizationModel?>((_) => null);

class OrganizationsProvider {
  final OrganizationsRepository _organizationsRepository;

  OrganizationsProvider(this._organizationsRepository);

  Future<List<OrganizationModel>> getAllOrgs([String? searchTerm]) async {
    final queryParams = <String, Object>{
      if (searchTerm != null) 'searchTerm': searchTerm,
    };
    return await _organizationsRepository.fetchAllOrganizations(
        queryParameters: queryParams);
  }

  Future<OrganizationModel> getOrgById({required String orgId}) async {
    final queryParams = {
      'orgId': orgId,
    };
    return await _organizationsRepository.fetchOrganization(
        queryParameters: queryParams);
  }

  // TODO: Finish update org function
  Future<String> editOrg({
    required String orgId,
    String? name,
    String? email,
    String? password,
    String? description,
    String? logoUrl,
  }) async {
    final data = <String, Object>{
      'id': orgId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (description != null) 'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
    };
    return await _organizationsRepository.editOrganization(data: data);
  }

  Future<String> deleteOrg({
    required String orgId,
  }) async {
    final data = {
      'orgId': orgId,
    };
    return await _organizationsRepository.deleteOrganization(data: data);
  }

  Future<List<OrganizationModel>> getFavoritedOrgs({
    required String userId,
  }) async {
    final queryParams = {
      'userId': userId,
    };
    return await _organizationsRepository.fetchFavoritedOrganizations(
        queryParameters: queryParams);
  }

  Future<List<OrganizationModel>> getSuggestedOrgs({
    required String userId,
  }) async {
    final queryParams = {
      'userId': userId,
    };
    return await _organizationsRepository.fetchSuggestedOrganizations(
        queryParameters: queryParams);
  }
}
