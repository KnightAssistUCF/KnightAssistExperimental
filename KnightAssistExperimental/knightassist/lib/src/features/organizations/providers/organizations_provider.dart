import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/providers/events_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

import '../../../global/states/edit_state.codegen.dart';
import '../models/organization_model.dart';
import '../repositories/organizations_repository.dart';

final userOrgProvider = FutureProvider.autoDispose((ref) async {
  final userId = ref.watch(authProvider.notifier).currentUserId;
  final orgProv = ref.watch(organizationsProvider);
  return await orgProv.getOrgById(orgId: userId);
});

final allOrgsProvider =
    FutureProvider.autoDispose<List<OrganizationModel>>((ref) async {
  final orgsProvider = ref.watch(organizationsProvider);
  return await orgsProvider.getAllOrgs();
});

final eventOrgProvider =
    FutureProvider.autoDispose<OrganizationModel>((ref) async {
  final currentEvent = ref.watch(currentEventProvider);
  final orgsProvider = ref.watch(organizationsProvider);

  return await orgsProvider.getOrgById(
      orgId: currentEvent!.sponsoringOrganizationId);
});

// Only call these if user role is volunteer
final favOrgsProvider =
    FutureProvider.autoDispose<List<OrganizationModel>>((ref) async {
  final orgsProvider = ref.watch(organizationsProvider);
  return await orgsProvider.getFavoritedOrgs();
});

final suggestedOrgsProvider =
    FutureProvider.autoDispose<List<OrganizationModel>>((ref) async {
  final orgsProvider = ref.watch(organizationsProvider);
  return await orgsProvider.getSuggestedOrgs();
});

final organizationStateProvider = StateProvider<EditState>((ref) {
  return const EditState.unprocessed();
});

final currentOrganizationProvider =
    StateProvider<OrganizationModel?>((_) => null);

class OrganizationsProvider {
  final OrganizationsRepository _organizationsRepository;
  final Ref _ref;

  OrganizationsProvider({
    required OrganizationsRepository organizationsRepository,
    required Ref ref,
  })  : _organizationsRepository = organizationsRepository,
        _ref = ref,
        super();

  Future<List<OrganizationModel>> getAllOrgs([String? searchTerm]) async {
    final queryParams = <String, Object>{
      if (searchTerm != null) 'searchTerm': searchTerm,
    };
    return await _organizationsRepository.fetchAllOrganizations(
        queryParameters: queryParams);
  }

  Future<OrganizationModel> getOrgById({required String orgId}) async {
    final queryParams = {
      'organizationID': orgId,
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
      'id': orgId,
    };
    return await _organizationsRepository.deleteOrganization(data: data);
  }

  Future<List<OrganizationModel>> getFavoritedOrgs() async {
    final authProv = _ref.watch(authProvider.notifier);
    final queryParams = {
      'userID': authProv.currentUserId,
    };
    return await _organizationsRepository.fetchFavoritedOrganizations(
        queryParameters: queryParams);
  }

  Future<List<OrganizationModel>> getSuggestedOrgs() async {
    final authProv = _ref.watch(authProvider.notifier);
    final queryParams = {
      'userID': authProv.currentUserId,
    };
    return await _organizationsRepository.fetchSuggestedOrganizations(
        queryParameters: queryParams);
  }
}
