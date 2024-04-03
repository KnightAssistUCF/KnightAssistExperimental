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
              onTap: () => AppRouter.popAndPushNamed(Routes.HomeScreenRoute),
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () =>
                  AppRouter.popAndPushNamed(Routes.EventsListScreenRoute),
            ),
            // Volunteer only options
            Visibility(
              visible: authProv.currentUserRole == UserRole.VOLUNTEER,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Organizations'),
                    onTap: () => AppRouter.popAndPushNamed(
                        Routes.OrganizationsListScreenRoute),
                  ),
                  ListTile(
                    title: const Text('Announcements'),
                    onTap: () => AppRouter.popAndPushNamed(
                        Routes.AnnouncementsListScreenRoute),
                  ),
                  ListTile(
                    title: const Text('QR Scanner'),
                    onTap: () =>
                        AppRouter.popAndPushNamed(Routes.QrScreenRoute),
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
                    onTap: () => AppRouter.popAndPushNamed(
                        Routes.FeedbackListScreenRoute),
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () => AppRouter.popAndPushNamed(Routes.ProfileScreenRoute),
            ),
          ],
        ),
      ),
    );
  }
}
