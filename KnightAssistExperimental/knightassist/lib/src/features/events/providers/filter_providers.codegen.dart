import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/typedefs.dart';
import '../models/event_model.dart';

part 'filter_providers.codegen.g.dart';

final searchFilterProvider = StateProvider.autoDispose<String>((ref) => '');
final eventDateFilterProvider = StateProvider<DateTime?>((ref) => null);

final filtersProvider = Provider<JSON>(
  (ref) {
    final eventDateFilter = ref.watch(eventDateFilterProvider.notifier).state;

    final filters = <String, dynamic>{
      'date': eventDateFilter,
    };

    return filters;
  },
);

@riverpod
Future<List<EventModel>> filteredEvents(FilteredEventsRef ref) {
  final queryParams = ref.watch(filtersProvider);
  return ref.watch(eventsProvider).getEventsList(queryParams);
}

@riverpod
List<EventModel> searchedEvents(
  SearchedEventsRef ref,
  List<EventModel> filteredEvents,
) {
  final _searchTerm = ref.watch(searchFilterProvider).toLowerCase();
  if (_searchTerm.isEmpty) {
    return filteredEvents;
  }
  return filteredEvents
      .where((event) => event.name.toLowerCase().contains(_searchTerm))
      .toList();
}
