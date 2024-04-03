import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/announcements/models/announcement_model.dart';
import 'package:knightassist/src/global/widgets/async_value_widget.dart';
import 'package:knightassist/src/global/widgets/custom_circular_loader.dart';
import 'package:knightassist/src/global/widgets/custom_refresh_indicator.dart';

import '../../../global/widgets/empty_state_widget.dart';
import '../../../global/widgets/error_response_handler.dart';
import '../../../helpers/constants/app_styles.dart';
import '../providers/announcements_provider.dart';
import 'announcements_list_item.dart';

class AnnouncementsList extends ConsumerWidget {
  const AnnouncementsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(favOrgAnnouncementsProvider),
      child: AsyncValueWidget<List<AnnouncementModel>>(
        value: ref.watch(favOrgAnnouncementsProvider),
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 70),
          child: CustomCircularLoader(),
        ),
        error: (error, st) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: ErrorResponseHandler(
              error: error,
              retryCallback: () => ref.refresh(favOrgAnnouncementsProvider),
              stackTrace: st,
            ),
          );
        },
        emptyOrNull: () => const EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No announcements found',
        ),
        data: (announcements) {
          return ListView.separated(
            itemCount: announcements.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            separatorBuilder: (_, __) => Insets.gapH20,
            itemBuilder: (_, i) => AnnouncementsListItem(
              announcement: announcements[i],
            ),
          );
        },
      ),
    );
  }
}
