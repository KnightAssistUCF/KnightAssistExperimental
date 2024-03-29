import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/providers/all_providers.dart';
import '../models/event_model.dart';

part 'search_providers.codegen.g.dart';

final searchProvider = StateProvider.autoDispose<String>((ref) => '');

@riverpod
Future<List<EventModel>> searchedEvents(SearchedEventsRef ref) {
  final queryParams = ref.watch(searchProvider);
  return ref.watch(eventsProvider).getAllEvents(queryParams);
}
