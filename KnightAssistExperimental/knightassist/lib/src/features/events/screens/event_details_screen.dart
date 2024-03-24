import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/features/events/models/event_model.codegen.dart';
import 'package:knightassist/src/features/events/providers/events_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

import '../../../config/routing/routes.dart';
import '../../../global/widgets/custom_text_button.dart';

class EventDetailsScreen extends ConsumerWidget {
  const EventDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    final event = ref.watch(currentEventProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Event Details
          Column(),

          // Edit Button if sponsoring org
          Visibility(
            visible: authProv.currentUserRole == UserRole.ORGANIZATION &&
                authProv.currentUserId == event!.sponsoringOrganization,
            child: CustomTextButton(
              child: const Center(
                child: Text(
                  'Edit Event',
                ),
              ),
              onPressed: () {
                AppRouter.pushNamed(Routes.EditEventScreenRoute);
              },
            ),
          ),

          // RSVP button if student
          Visibility(
            visible: authProv.currentUserRole == UserRole.VOLUNTEER,
            child: CustomTextButton(
              child: const Center(
                child: Text(
                  'RSVP',
                ),
              ),
              onPressed: () {
                // RSVP dialog
              },
            ),
          ),
        ],
      ),
    );
  }
}
