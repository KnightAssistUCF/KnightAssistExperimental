import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/config/routing/routes.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/features/events/providers/events_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/async_value_widget.dart';
import 'package:knightassist/src/global/widgets/custom_drawer.dart';
import 'package:knightassist/src/global/widgets/custom_text_button.dart';
import 'package:knightassist/src/global/widgets/custom_top_bar.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';
import 'package:knightassist/src/helpers/extensions/datetime_extension.dart';

import '../../../global/widgets/custom_circular_loader.dart';
import '../../../global/widgets/empty_state_widget.dart';
import '../../../global/widgets/error_response_handler.dart';
import '../../../helpers/constants/app_colors.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
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

                    // Volunteer Only
                    Visibility(
                      visible: authProv.currentUserRole == UserRole.VOLUNTEER,
                      child: Column(
                        children: [
                          AsyncValueWidget(
                            value: ref.watch(suggestedEventsProvider),
                            loading: () => const CustomCircularLoader(),
                            error: (error, st) => ErrorResponseHandler(
                              error: error,
                              stackTrace: st,
                              retryCallback: () =>
                                  ref.refresh(suggestedEventsProvider),
                            ),
                            emptyOrNull: () => const EmptyStateWidget(
                              height: 395,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20),
                              title: 'No suggested events',
                            ),
                            data: (events) => SizedBox(
                              height: 330,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (var event in events)
                                    Card(
                                      child: InkWell(
                                        onTap: () {
                                          ref
                                              .read(
                                                  currentEventProvider.notifier)
                                              .state = event;
                                          AppRouter.pushNamed(
                                              Routes.EventDetailsScreenRoute);
                                        },
                                        child: SizedBox(
                                          height: 150,
                                          width: 320,
                                          child: Column(
                                            children: [
                                              const Text(
                                                "Suggested Events",
                                                style: TextStyle(
                                                  color: AppColors
                                                      .textWhite80Color,
                                                ),
                                              ),
                                              const Divider(height: 15),
                                              Wrap(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                        event.profilePicPath,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: 175,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                        image: imageProvider,
                                                      )),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          event.name,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                            color: AppColors
                                                                .textWhite80Color,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          event.startTime
                                                              .toDateString(),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .textWhite80Color,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          event.location,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .textWhite80Color,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Organization Only Buttons
                    Visibility(
                      visible:
                          authProv.currentUserRole == UserRole.ORGANIZATION,
                      child: Column(
                        children: [
                          CustomTextButton(
                            width: double.infinity,
                            onPressed: () =>
                                AppRouter.pushNamed(Routes.AddEventScreenRoute),
                            color: AppColors.primaryColor,
                            child: const Center(
                              child: Text(
                                'Add Event',
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
                                Routes.AddAnnouncementScreenRoute),
                            color: AppColors.primaryColor,
                            child: const Center(
                              child: Text(
                                'Add Announcement',
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
      ),
    );
  }
}
