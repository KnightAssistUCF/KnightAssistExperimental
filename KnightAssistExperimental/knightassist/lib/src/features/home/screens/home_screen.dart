import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/config/routing/routes.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/custom_drawer.dart';
import 'package:knightassist/src/global/widgets/custom_text_button.dart';
import 'package:knightassist/src/global/widgets/custom_top_bar.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';

import '../../../helpers/constants/app_colors.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        child: ScrollableColumn(
          children: [
            CustomTopBar(
              scaffoldKey: _scaffoldKey,
              title: 'Home',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    'Welcome',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 45,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (authProv.currentUserRole == UserRole.ORGANIZATION)
                              ? authProv.currentUserOrgName!
                              : "${authProv.currentUserFirstName} ${authProv.currentUserLastName!}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Volunteer Only Buttons
                  Visibility(
                    visible: authProv.currentUserRole == UserRole.VOLUNTEER,
                    child: Column(
                      children: [
                        CustomTextButton(
                          width: double.infinity,
                          onPressed: () =>
                              AppRouter.pushNamed(Routes.EventsListScreenRoute),
                          color: AppColors.primaryColor,
                          child: const Center(
                            child: Text(
                              'Explore Events',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextButton(
                          width: double.infinity,
                          onPressed: () => AppRouter.pushNamed(
                              Routes.OrganizationsListScreenRoute),
                          color: AppColors.primaryColor,
                          child: const Center(
                            child: Text(
                              'Explore Organizations',
                              style: TextStyle(
                                color: Colors.white,
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

                  // Organization Only Buttons
                  Visibility(
                    visible: authProv.currentUserRole == UserRole.ORGANIZATION,
                    child: Column(
                      children: [
                        CustomTextButton(
                          width: double.infinity,
                          onPressed: () =>
                              AppRouter.pushNamed(Routes.EventsListScreenRoute),
                          color: AppColors.primaryColor,
                          child: const Center(
                            child: Text(
                              'View Events',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextButton(
                          width: double.infinity,
                          onPressed: () => AppRouter.pushNamed(
                              Routes.FeedbackListScreenRoute),
                          color: AppColors.primaryColor,
                          child: const Center(
                            child: Text(
                              'View Feedback',
                              style: TextStyle(
                                color: Colors.white,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
