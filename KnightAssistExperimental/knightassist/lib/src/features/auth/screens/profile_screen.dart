import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

import '../../../config/routing/routing.dart';
import '../../../global/widgets/custom_text_button.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 65),

            // Logout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logout Icon
                RotatedBox(
                  quarterTurns: 2,
                  child: InkResponse(
                    radius: 26,
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
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
                    color: Colors.white,
                    size: 30,
                  ),
                  onTap: () {
                    AppRouter.pushNamed(Routes.EditProfileScreenRoute);
                  },
                )
              ],
            ),

            const SizedBox(height: 20),

            Flexible(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name Label
                    const Text(
                      'Name',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Name
                    Text(
                      authProv.currentUserName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),

                    const Spacer(),

                    // Email Label
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Email
                    Text(
                      authProv.currentUserEmail,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),

            // Event History Button for volunteers
            (authProv.currentUserRole == UserRole.VOLUNTEER)
                ? CustomTextButton(
                    width: double.infinity,
                    color: AppColors.secondaryColor,
                    onPressed: () {
                      AppRouter.pushNamed(Routes.EventHistoryScreenRoute);
                    },
                    child: const Center(
                      child: Text(
                        'Event History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
