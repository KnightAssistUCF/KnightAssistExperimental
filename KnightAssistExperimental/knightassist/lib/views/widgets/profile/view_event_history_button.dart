import 'package:flutter/material.dart';
import 'package:knightassist/routes/app_router.dart';

import '../../../helper/utils/constants.dart';
import '../../../routes/routes.dart';
import '../common/custom_text_button.dart';

class ViewEventHistoryButton extends StatelessWidget {
  const ViewEventHistoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton.outlined(
      width: double.infinity,
      onPressed: () => AppRouter.pushNamed(Routes.EventHistoryRoute),
      border: Border.all(color: Constants.primaryColor, width: 4),
      child: const Center(
        child: Text(
          'View Event History',
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 15,
            letterSpacing: 0.7,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
