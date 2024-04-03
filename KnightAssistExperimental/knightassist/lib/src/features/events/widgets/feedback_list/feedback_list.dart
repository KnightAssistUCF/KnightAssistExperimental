import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';
import 'package:knightassist/src/features/events/providers/feedback_provider.dart';
import 'package:knightassist/src/global/widgets/async_value_widget.dart';
import 'package:knightassist/src/global/widgets/custom_circular_loader.dart';
import 'package:knightassist/src/global/widgets/custom_refresh_indicator.dart';
import 'package:knightassist/src/helpers/constants/app_styles.dart';

import '../../../../global/widgets/empty_state_widget.dart';
import '../../../../global/widgets/error_response_handler.dart';
import 'feedback_list_item.dart';

class FeedbackList extends ConsumerWidget {
  const FeedbackList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(orgFeedbackProvider),
      child: AsyncValueWidget<List<FeedbackModel>>(
        value: ref.watch(orgFeedbackProvider),
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 70),
          child: CustomCircularLoader(),
        ),
        error: (error, st) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: ErrorResponseHandler(
            error: error,
            retryCallback: () => ref.refresh(orgFeedbackProvider),
            stackTrace: st,
          ),
        ),
        emptyOrNull: () => const EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No feedback found',
        ),
        data: (feedback) {
          return ListView.separated(
            itemCount: feedback.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            separatorBuilder: (_, __) => Insets.gapH20,
            itemBuilder: (_, i) => FeedbackListItem(
              feedback: feedback[i],
            ),
          );
        },
      ),
    );
  }
}
