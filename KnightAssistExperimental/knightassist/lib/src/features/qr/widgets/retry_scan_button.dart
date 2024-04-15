import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/custom_text_button.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

class RetryScanButton extends ConsumerWidget {
  final bool checkIn;
  final String eventId;
  const RetryScanButton(
      {super.key, required this.checkIn, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton.outlined(
        width: double.infinity,
        onPressed: () {
          if (checkIn) {
            ref.read(qrProvider).checkIn(eventId: eventId);
          } else {
            ref.read(qrProvider).checkOut(eventId: eventId);
          }
        },
        border: Border.all(width: 4, color: AppColors.textWhite80Color),
        child: Center(
          child: Text(
            checkIn ? 'Retry Check In' : 'Retry Check Out',
            style: const TextStyle(
              color: AppColors.textWhite80Color,
              fontSize: 15,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
