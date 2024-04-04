import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';

class FeedbackListItem extends ConsumerWidget {
  final FeedbackModel feedback;

  const FeedbackListItem({
    super.key,
    required this.feedback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          children: [
            Text(
              feedback.eventName,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.textWhite80Color,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            Text(
              feedback.volunteerName,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textWhite80Color,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            RatingBarIndicator(
              rating: feedback.rating.toDouble(),
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 32,
              direction: Axis.horizontal,
            ),
            const SizedBox(height: 5),
            Text(
              feedback.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
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
