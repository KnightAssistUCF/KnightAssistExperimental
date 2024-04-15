import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/config/routing/routes.dart';

import '../../../global/widgets/custom_text_button.dart';
import '../../../helpers/constants/app_colors.dart';
import '../providers/qr_provider.dart';

class LeaveFeedbackButton extends ConsumerWidget {
  const LeaveFeedbackButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton(
        width: double.infinity,
        onPressed: () {
          ref.invalidate(qrStateProvider);
          AppRouter.popUntil(Routes.HomeScreenRoute);
        },
        color: AppColors.textWhite80Color,
        child: const Center(
          child: Text(
            'Leave Feedback',
            style: TextStyle(
              color: AppColors.primaryColor,
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
