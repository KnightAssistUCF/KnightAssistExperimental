import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/providers/all_providers.dart';
import '../models/event_model.dart';

part 'search_providers.codegen.g.dart';

final searchProvider = StateProvider.autoDispose<String>((ref) => '');

@riverpod
Future<List<EventModel>> searchedEvents(SearchedEventsRef ref) {
  final queryParams = ref.watch(searchProvider);
  final authProv = ref.watch(authProvider.notifier);
  if (authProv.currentUserRole == UserRole.VOLUNTEER) {
    return ref.watch(eventsProvider).getAllEvents(queryParams);
  } else {
    return ref
        .watch(eventsProvider)
        .getOrgEvents(orgId: authProv.currentUserId, searchTerm: queryParams);
  }
}
