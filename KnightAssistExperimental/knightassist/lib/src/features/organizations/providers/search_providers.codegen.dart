import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/typedefs.dart';
import '../models/organization_model.dart';

part 'search_providers.codegen.g.dart';

final searchFilterProvider = StateProvider.autoDispose<String>((ref) => '');

final filtersProvider = Provider<JSON>((ref) {
  final filters = <String, dynamic>{};
  return filters;
});

@riverpod
Future<List<OrganizationModel>> filteredOrgs(FilteredOrgsRef ref) {
  final queryParams = ref.watch(filtersProvider);
  return ref.watch(organizationsProvider).getAllOrgs(queryParams);
}

@riverpod
List<OrganizationModel> searchedOrgs(
    SearchedOrgsRef ref, List<OrganizationModel> orgs) {
  final searchTerm = ref.watch(searchFilterProvider).toLowerCase();
  if (searchTerm.isEmpty) {
    return orgs;
  }
  return orgs
      .where((org) => org.name.toLowerCase().contains(searchTerm))
      .toList();
}
