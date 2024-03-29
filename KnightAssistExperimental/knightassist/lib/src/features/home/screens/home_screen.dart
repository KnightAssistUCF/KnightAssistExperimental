import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/config/routing/routes.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/custom_text_button.dart';
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
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              ListTile(
                title: const Text('Home'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Events'),
                onTap: () => AppRouter.pushNamed(Routes.EventsListScreenRoute),
              ),
              // Volunteer only options
              Visibility(
                visible: authProv.currentUserRole == UserRole.VOLUNTEER,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Organizations'),
                      onTap: () => AppRouter.pushNamed(
                          Routes.OrganizationsListScreenRoute),
                    ),
                    ListTile(
                      title: const Text('QR Scanner'),
                      onTap: () => AppRouter.pushNamed(Routes.QrScreenRoute),
                    ),
                  ],
                ),
              ),
              // Organization only options
              Visibility(
                visible: authProv.currentUserRole == UserRole.ORGANIZATION,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Feedback'),
                      onTap: () =>
                          AppRouter.pushNamed(Routes.FeedbackListScreenRoute),
                    )
                  ],
                ),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () => AppRouter.pushNamed(Routes.ProfileScreenRoute),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ScrollableColumn(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Drawer icon
                  InkResponse(
                    radius: 26,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 15),
                      child: Icon(
                        Icons.menu,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => _scaffoldKey.currentState!.openDrawer(),
                  ),

                  // Profile Icon
                  InkResponse(
                    radius: 26,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20, top: 10, bottom: 15),
                      child: Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    onTap: () {
                      AppRouter.pushNamed(Routes.ProfileScreenRoute);
                    },
                  ),
                ],
              ),
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

                  const SizedBox(height: 50),

                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (authProv.currentUserRole == UserRole.ORGANIZATION)
                              ? authProv.currentUserOrgName!
                              : '{$authProv.currentUserFirstName} {$authProv.currentUserLastName}',
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
