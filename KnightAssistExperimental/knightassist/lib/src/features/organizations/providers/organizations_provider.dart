import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/providers/events_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

import '../../../global/states/edit_state.codegen.dart';
import '../models/organization_model.dart';
import '../repositories/organizations_repository.dart';

final userOrgProvider = FutureProvider.autoDispose((ref) async {
  final userId = ref.watch(authProvider.notifier).currentUserId;
  return await ref.watch(organizationsProvider).getOrgById(orgId: userId);
});

final allOrgsProvider =
    FutureProvider.autoDispose<List<OrganizationModel>>((ref) async {
  return await ref.watch(organizationsProvider).getAllOrgs();
});

final eventOrgProvider =
    FutureProvider.autoDispose<OrganizationModel>((ref) async {
  final currentEvent = ref.watch(currentEventProvider);
  return await ref
      .watch(organizationsProvider)
      .getOrgById(orgId: currentEvent!.sponsoringOrganizationId);
});

// Only call these if user role is volunteer
final favOrgsProvider =
    FutureProvider.autoDispose<List<OrganizationModel>>((ref) async {
  return await ref.watch(organizationsProvider).getFavoritedOrgs();
});

final suggestedOrgsProvider =
    FutureProvider.autoDispose<List<OrganizationModel>>((ref) async {
  return await ref.watch(organizationsProvider).getSuggestedOrgs();
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
    final imgProv = _ref.watch(imagesProvider);
    final queryParams = <String, Object>{
      if (searchTerm != null) 'searchTerm': searchTerm,
    };
    List<OrganizationModel> temp = await _organizationsRepository
        .fetchAllOrganizations(queryParameters: queryParams);
    for (OrganizationModel o in temp) {
      o.profilePicPath = await imgProv.retrieveImage(type: '2', id: o.id);
      o.backgroundPicPath = await imgProv.retrieveImage(type: '4', id: o.id);
    }
    if (searchTerm != null) {
      temp =
          temp.where((element) => element.name.contains(searchTerm)).toList();
    }
    return temp;
  }

  Future<OrganizationModel> getOrgById({required String orgId}) async {
    final imgProv = _ref.watch(imagesProvider);
    final queryParams = {
      'organizationID': orgId,
    };
    final temp = await _organizationsRepository.fetchOrganization(
        queryParameters: queryParams);
    temp.profilePicPath = await imgProv.retrieveImage(type: '2', id: temp.id);
    temp.backgroundPicPath =
        await imgProv.retrieveImage(type: '4', id: temp.id);
    return temp;
  }

  // TODO: Finish update org function
  Future<String> editOrg({
    required String orgId,
    String? name,
    String? email,
    String? password,
    String? description,
  }) async {
    final data = <String, Object>{
      'id': orgId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (description != null) 'description': description,
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
    final imgProv = _ref.watch(imagesProvider);
    final queryParams = {
      'userID': authProv.currentUserId,
    };
    final temp = await _organizationsRepository.fetchFavoritedOrganizations(
        queryParameters: queryParams);
    for (OrganizationModel o in temp) {
      o.profilePicPath = await imgProv.retrieveImage(type: '2', id: o.id);
      o.backgroundPicPath = await imgProv.retrieveImage(type: '4', id: o.id);
    }
    return temp;
  }

  Future<List<OrganizationModel>> getSuggestedOrgs() async {
    final authProv = _ref.watch(authProvider.notifier);
    final imgProv = _ref.watch(imagesProvider);
    final queryParams = {
      'userID': authProv.currentUserId,
    };
    final temp = await _organizationsRepository.fetchSuggestedOrganizations(
        queryParameters: queryParams);
    for (OrganizationModel o in temp) {
      o.profilePicPath = await imgProv.retrieveImage(type: '2', id: o.id);
      o.backgroundPicPath = await imgProv.retrieveImage(type: '4', id: o.id);
    }
    return temp;
  }
}
