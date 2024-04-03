import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/announcements/models/announcement_model.dart';
import 'package:knightassist/src/helpers/extensions/datetime_extension.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_sizes.dart';

class AnnouncementsListItem extends ConsumerWidget {
  final AnnouncementModel announcement;

  const AnnouncementsListItem({
    super.key,
    required this.announcement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          children: [
            Text(
              announcement.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textWhite80Color,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            Text(
              announcement.date.toDateString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textWhite80Color,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            Text(
              announcement.content,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textWhite80Color,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
