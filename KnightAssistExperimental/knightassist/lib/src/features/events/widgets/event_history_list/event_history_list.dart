import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';

import '../../../../global/widgets/async_value_widget.dart';
import '../../../../global/widgets/custom_circular_loader.dart';
import '../../../../global/widgets/custom_refresh_indicator.dart';
import '../../../../global/widgets/empty_state_widget.dart';
import '../../../../global/widgets/error_response_handler.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../providers/event_history_provider.dart';
import 'event_history_list_item.dart';

class EventHistoryList extends ConsumerWidget {
  const EventHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(userHistoryProvider),
      child: AsyncValueWidget<List<EventHistoryModel>>(
        value: ref.watch(userHistoryProvider),
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 70),
          child: CustomCircularLoader(),
        ),
        error: (error, st) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: ErrorResponseHandler(
            error: error,
            retryCallback: () => ref.refresh(userHistoryProvider),
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
        data: (histories) {
          final events = histories;
          return ListView.separated(
            itemCount: events.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            separatorBuilder: (_, __) => Insets.gapH20,
            itemBuilder: (_, i) => EventHistoryListItem(
              eventHistory: events[i],
            ),
          );
        },
      ),
    );
  }
}
