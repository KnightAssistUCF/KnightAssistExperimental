import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/features/events/providers/events_provider.dart';
import 'package:knightassist/src/features/volunteers/models/volunteer_model.dart';
import 'package:knightassist/src/features/volunteers/providers/volunteers_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';
import 'package:knightassist/src/global/widgets/async_value_widget.dart';
import 'package:knightassist/src/global/widgets/custom_circular_loader.dart';
import 'package:knightassist/src/global/widgets/custom_dialog.dart';
import 'package:knightassist/src/global/widgets/error_response_handler.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';
import 'package:knightassist/src/helpers/constants/app_sizes.dart';

import '../../../config/routing/routes.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../helpers/constants/app_colors.dart';

class EventDetailsScreen extends HookConsumerWidget {
  const EventDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    final event = ref.watch(currentEventProvider);
    final eventsProv = ref.watch(eventsProvider);

    ref.listen<FutureState<String>>(
      rsvpStateProvider,
      (previous, rsvpState) async {
        rsvpState.maybeWhen(
          data: (message) async {
            await showDialog<bool>(
                context: context,
                builder: (ctx) => CustomDialog.alert(
                      title: 'Success',
                      body: message,
                      buttonText: 'OK',
                      onButtonPressed: () => AppRouter.pop(),
                    ));
          },
          failed: (reason) async {
            await showDialog<bool>(
              context: context,
              builder: (ctx) => CustomDialog.alert(
                title: 'Failed',
                body: reason,
                buttonText: 'Retry',
              ),
            );
          },
          orElse: () {},
        );
      },
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ScrollableColumn(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Icon
                    InkResponse(
                      radius: 26,
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        size: 32,
                        color: Colors.white,
                      ),
                      onTap: () => AppRouter.pop(),
                    ),
                    // Title
                    Text(
                      event!.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox.shrink(),
                  ],
                ),
              ),
              // Event Details
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(Sizes.p16),
                      child: Text('Image Placeholder'),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(Sizes.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(event.name,
                              style: Theme.of(context).textTheme.titleLarge),
                          Text(event.description),
                          Text(event.maxAttendees.toString()),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // Feedback card

              // Edit Button if sponsoring org
              Visibility(
                visible: authProv.currentUserRole == UserRole.ORGANIZATION &&
                    authProv.currentUserId == event.sponsoringOrganizationId,
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
              ),

              // RSVP and Feedback button if student
              Visibility(
                visible: authProv.currentUserRole == UserRole.VOLUNTEER,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Consumer(
                    builder: (context, ref, child) {
                      return AsyncValueWidget<VolunteerModel>(
                        value: ref.watch(userVolunteerProvider),
                        loading: () => const CustomCircularLoader(),
                        error: (error, st) => ErrorResponseHandler(
                          error: error,
                          stackTrace: st,
                          retryCallback: () =>
                              ref.refresh(userVolunteerProvider),
                        ),
                        data: (volunteer) {
                          return CustomTextButton(
                            width: double.infinity,
                            color: volunteer.eventRsvpIds.contains(event.id) ||
                                    event.maxAttendees <=
                                        event.registeredVolunteerIds.length
                                ? AppColors.buttonGreyColor
                                : AppColors.secondaryColor,
                            child: Consumer(
                              builder: (context, ref, child) {
                                final _rsvpState = ref.watch(rsvpStateProvider);
                                return _rsvpState.maybeWhen(
                                  loading: () => const Center(
                                    child: SpinKitRing(
                                      color: Colors.white,
                                      size: 30,
                                      lineWidth: 4,
                                      duration: Duration(milliseconds: 1100),
                                    ),
                                  ),
                                  orElse: () => child!,
                                );
                              },
                              child: Center(
                                child: Text(
                                  volunteer.eventRsvpIds.contains(event.id)
                                      ? 'Cancel RSVP'
                                      : event.maxAttendees <=
                                              event
                                                  .registeredVolunteerIds.length
                                          ? 'Event Full'
                                          : 'RSVP',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    letterSpacing: 0.7,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (event.maxAttendees <=
                                  event.registeredVolunteerIds.length) {
                                return;
                              }
                              if (volunteer.eventRsvpIds.contains(event.id)) {
                                await eventsProv.cancelRSVP(
                                  eventId: event.id,
                                  eventName: event.name,
                                );
                              } else {
                                await eventsProv.addRSVP(
                                  eventId: event.id,
                                  eventName: event.name,
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
