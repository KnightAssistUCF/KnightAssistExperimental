import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';
import 'package:knightassist/src/helpers/extensions/datetime_extension.dart';

import '../../../../helpers/constants/app_sizes.dart';

class EventHistoryListItem extends ConsumerWidget {
  final EventHistoryModel eventHistory;

  const EventHistoryListItem({
    super.key,
    required this.eventHistory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          children: [
            Text(
              eventHistory.eventName,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            Text(
              eventHistory.orgName,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            Text(
              eventHistory.checkIn.toDateString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            Text(
              eventHistory.checkOut.toDateString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            ),
            Text(
              eventHistory.hours.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            ),
            Visibility(
              visible: eventHistory.wasAdjusted,
              child: Column(
                children: [
                  Text(
                    "Hours adjusted by ${eventHistory.adjustedTotal!}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "Change made by ${eventHistory.whoAdjusted!}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
