import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';
import 'package:knightassist/src/features/events/providers/filter_providers.codegen.dart';
import 'package:knightassist/src/features/events/widgets/events_list/events_list_item.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/async_value_widget.dart';
import 'package:knightassist/src/global/widgets/custom_circular_loader.dart';
import 'package:knightassist/src/global/widgets/custom_refresh_indicator.dart';
import 'package:knightassist/src/global/widgets/empty_state_widget.dart';
import 'package:knightassist/src/global/widgets/error_response_handler.dart';
import 'package:knightassist/src/helpers/constants/app_styles.dart';

class OrgEventsList extends ConsumerWidget {
  final String org;
  const OrgEventsList({super.key, required this.org});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(filtersProvider),
      child: AsyncValueWidget<List<EventModel>>(
        value: organizationsProvider.,
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
          final events = ref.watch(orgEventsProvider(filteredEvents));
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
