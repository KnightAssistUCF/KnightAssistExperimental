import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/organizations/models/organization_model.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/custom_text_button.dart';
import 'package:knightassist/src/helpers/constants/app_sizes.dart';

import '../../../../config/routing/app_router.dart';
import '../../../../config/routing/routes.dart';
import '../../../auth/enums/user_role_enum.dart';
import '../../models/event_model.dart';
import '../../providers/events_provider.dart';

class EventsListItem extends ConsumerWidget {
  final EventModel event;

  const EventsListItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);

    return InkResponse(
      onTap: () {
        ref.read(currentEventProvider.notifier).state = event;
        AppRouter.pushNamed(Routes.EventDetailsScreenRoute);
      },
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(),
                ),
                const SizedBox(width: 10),
                Text(
                  event.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                  textAlign: TextAlign.start,
                ),
                Text(
                  event.location,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                ),

                // TODO: Figure out how to pull sponsoring org info here

                /*
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
                      ref
                          .read(currentEventProvider.notifier)
                          .update((_) => event);
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
                */
              ],
            )),
      ),
    );
  }
}
