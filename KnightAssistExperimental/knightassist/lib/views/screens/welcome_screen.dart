import 'package:flutter/material.dart';
import 'package:knightassist/helper/extensions/context_extensions.dart';
import 'package:knightassist/routes/app_router.dart';

import '../../helper/utils/constants.dart';
import '../../routes/routes.dart';
import '../widgets/common/custom_text_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 125, 20, Constants.bottomInsets),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading text
            Text(
              'KnightAssist',
              style: context.headline1.copyWith(color: Constants.primaryColor),
            ),

            const SizedBox(height: 35),

            // Welcome message
            Text(
              'Welcome',
              style: context.headline3,
            ),

            const Spacer(),

            // Login row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Login button
                Expanded(
                  child: CustomTextButton.gradient(
                    width: double.infinity,
                    onPressed: () {
                      AppRouter.pushNamed(Routes.LoginScreenRoute);
                    },
                    gradient: Constants.buttonGradientGreen,
                    child: const Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 17),

            // Register button
            CustomTextButton.outlined(
              width: double.infinity,
              onPressed: () {
                AppRouter.pushNamed(Routes.RegisterScreenRoute);
              },
              border: Border.all(color: Constants.primaryColor, width: 4),
              child: const Center(
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 15,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
