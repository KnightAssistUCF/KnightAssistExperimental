import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../global/widgets/async_value_widget.dart';
import '../../../../global/widgets/custom_circular_loader.dart';
import '../../../../global/widgets/custom_refresh_indicator.dart';
import '../../../../global/widgets/empty_state_widget.dart';
import '../../../../global/widgets/error_response_handler.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../models/event_model.dart';
import '../../providers/filter_providers.codegen.dart';
import 'events_list_item.dart';

class EventsList extends ConsumerWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(filtersProvider),
      child: AsyncValueWidget<List<EventModel>>(
        value: ref.watch(filteredEventsProvider),
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 70),
          child: CustomCircularLoader(),
        ),
        error: (error, st) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: ErrorResponseHandler(
            error: error,
            retryCallback: () => ref.refresh(filtersProvider),
            stackTrace: st,
          ),
        ),
        emptyOrNull: () => const EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No events found',
          subtitle: 'Try changing the search term',
        ),
        data: (filteredEvents) {
          final events = ref.watch(searchedEventsProvider(filteredEvents));
          return ListView.separated(
            itemCount: events.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            separatorBuilder: (_, __) => Insets.gapH20,
            itemBuilder: (_, i) => EventsListItem(
              event: events[i],
            ),
          );
        },
      ),
    );
  }
}
