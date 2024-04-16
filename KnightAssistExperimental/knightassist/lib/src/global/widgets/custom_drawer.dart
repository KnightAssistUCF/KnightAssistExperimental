import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/routing/routing.dart';
import '../../features/auth/enums/user_role_enum.dart';
import '../providers/all_providers.dart';

class CustomDrawer extends HookConsumerWidget {
  CustomDrawer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                AppRouter.popUntilRoot();
              },
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () {
                AppRouter.popUntilRoot();
                AppRouter.pushNamed(Routes.EventsListScreenRoute);
              },
            ),
            // Volunteer only options
            Visibility(
              visible: authProv.currentUserRole == UserRole.VOLUNTEER,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Organizations'),
                    onTap: () {
                      AppRouter.popUntilRoot();
                      AppRouter.pushNamed(Routes.OrganizationsListScreenRoute);
                    },
                  ),
                  ListTile(
                    title: const Text('Announcements'),
                    onTap: () {
                      AppRouter.popUntilRoot();
                      AppRouter.pushNamed(Routes.AnnouncementsListScreenRoute);
                    },
                  ),
                  ListTile(
                    title: const Text('Event History'),
                    onTap: () {
                      AppRouter.popUntilRoot();
                      AppRouter.pushNamed(Routes.EventHistoryListScreenRoute);
                    },
                  ),
                  ListTile(
                    title: const Text('QR Scanner'),
                    onTap: () {
                      AppRouter.popUntilRoot();
                      AppRouter.pushNamed(Routes.QrScreenRoute);
                    },
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
                    onTap: () {
                      AppRouter.popUntilRoot();
                      AppRouter.pushNamed(Routes.FeedbackListScreenRoute);
                    },
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Leaderboard'),
              onTap: () {
                AppRouter.popUntilRoot();
                AppRouter.pushNamed(Routes.LeaderboardScreenRoute);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                AppRouter.popUntilRoot();
                AppRouter.pushNamed(Routes.ProfileScreenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
