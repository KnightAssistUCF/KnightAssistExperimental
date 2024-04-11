import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/widgets/custom_network_image.dart';
import 'package:knightassist/src/global/widgets/custom_text.dart';
import 'package:knightassist/src/helpers/constants/constants.dart';
import 'package:knightassist/src/helpers/extensions/datetime_extension.dart';

import '../../../../config/routing/app_router.dart';
import '../../../../config/routing/routes.dart';
import '../../models/event_model.dart';
import '../../providers/events_provider.dart';
import '../../skeletons/event_image_placeholder.dart';

class EventsListItem extends ConsumerWidget {
  final EventModel event;

  const EventsListItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkResponse(
      onTap: () {
        ref.read(currentEventProvider.notifier).state = event;
        AppRouter.pushNamed(Routes.EventDetailsScreenRoute);
      },
      child: ClipRRect(
        borderRadius: Corners.rounded9,
        child: SizedBox(
          height: 230,
          child: Stack(
            children: [
              // Event Image
              Positioned.fill(
                child: CustomNetworkImage(
                  fit: BoxFit.cover,
                  borderRadius: Corners.none,
                  imageUrl: event.profilePicPath,
                  placeholder: const EventImagePlaceholder(),
                  errorWidget: const EventImagePlaceholder(),
                ),
              ),

              // Details
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 107,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.97),
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      stops: const [0.35, 0.67, 1],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // DateTime
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Date
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 18,
                              ),
                              Insets.gapW(7),
                              CustomText(
                                event.startTime.toDateString('d MMM, y'),
                                textAlign: TextAlign.center,
                                fontSize: 12,
                              ),
                            ],
                          ),

                          // Times
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                size: 18,
                              ),
                              Insets.gapW(7),
                              CustomText(
                                '${TimeOfDay.fromDateTime(event.startTime).format(context)} - ${TimeOfDay.fromDateTime(event.endTime).format(context)}',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ],
                      ),

                      Insets.gapH10,

                      // Name
                      CustomText(
                        event.name,
                        maxLines: 2,
                        fontSize: 18,
                        overflow: TextOverflow.fade,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      /*
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: event.profilePicPath,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  event.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.textWhite80Color),
                  textAlign: TextAlign.start,
                ),
                Text(
                  event.location,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textWhite80Color),
                  textAlign: TextAlign.start,
                ),

                /*
                // Edit Button if sponsoring org
                Visibility(
                  visible: authProv.currentUserRole == UserRole.ORGANIZATION &&
                      authProv.currentUserId == event.sponsoringOrganizationId,
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
      */
    );
  }
}
