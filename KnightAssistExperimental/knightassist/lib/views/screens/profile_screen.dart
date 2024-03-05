import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/enums/user_role_enum.dart';
import 'package:knightassist/views/widgets/profile/user_profile_details.dart';

import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';

import '../../providers/all_providers.dart';

import '../../routes/routes.dart';
import '../../routes/app_router.dart';
import '../widgets/profile/view_event_history_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 65),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Log out icon
                RotatedBox(
                  quarterTurns: 2,
                  child: InkResponse(
                    radius: 26,
                    child: const Icon(
                      Icons.logout,
                      color: Constants.primaryColor,
                      size: 30,
                    ),
                    onTap: () {
                      ref.read(authProvider.notifier).logout();
                      AppRouter.popUntilRoot();
                    },
                  ),
                ),
                // Edit profile icon
                InkResponse(
                  radius: 26,
                  child: const Icon(
                    Icons.manage_accounts_sharp,
                    color: Constants.primaryColor,
                    size: 30,
                  ),
                  onTap: () {
                    AppRouter.pushNamed(Routes.ChangePasswordScreenRoute);
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome',
              style: context.headline1.copyWith(
                color: Constants.primaryColor,
                fontSize: 45,
              ),
            ),
            const SizedBox(height: 50),
            Flexible(
              child: SizedBox(
                width: double.infinity,
                child: UserProfileDetails(),
              ),
            ),
            const SizedBox(height: 60),
            const ViewEventHistoryButton(),
            const SizedBox(height: Constants.bottomInsetsLow + 5),
          ],
        ),
      ),
    );
  }
}
