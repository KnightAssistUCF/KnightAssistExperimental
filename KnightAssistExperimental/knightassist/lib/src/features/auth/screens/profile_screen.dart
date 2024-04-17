import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/features/organizations/providers/organizations_provider.dart';
import 'package:knightassist/src/features/volunteers/providers/volunteers_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/async_value_widget.dart';
import 'package:knightassist/src/global/widgets/custom_network_image.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

import '../../../config/routing/routing.dart';
import '../../../global/widgets/custom_circular_loader.dart';
import '../../../global/widgets/custom_text.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../global/widgets/error_response_handler.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen();

  String getTimeStringFromDouble(double value) {
    if (value < 0) return 'Invalid Value';
    int flooredValue = value.floor();
    double decimalValue = value - flooredValue;
    String hourValue = getHourString(flooredValue);
    String minuteString = getMinuteString(decimalValue);

    return '$hourValue:$minuteString';
  }

  String getMinuteString(double decimalValue) {
    return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
  }

  String getHourString(int flooredValue) {
    return '$flooredValue';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: ScrollableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 20),
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
                  const CustomText(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 32),
                ],
              ),
            ),

            authProv.currentUserRole == UserRole.VOLUNTEER
                ? Consumer(
                    builder: (context, ref, child) {
                      return AsyncValueWidget(
                          value: ref.watch(userVolunteerProvider),
                          loading: () => const CustomCircularLoader(),
                          error: (error, st) => ErrorResponseHandler(
                                error: error,
                                stackTrace: st,
                                retryCallback: () =>
                                    ref.refresh(userVolunteerProvider),
                              ),
                          data: (volunteer) {
                            return Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // First and Last Name
                                    Text(
                                      '${volunteer.firstName} ${volunteer.lastName}',
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    CachedNetworkImage(
                                      imageUrl: volunteer.profilePicPath!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Email
                                    Text(
                                      volunteer.email,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    // Total Hours
                                    const Text(
                                      'Total Hours',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),

                                    Text(
                                      getTimeStringFromDouble(
                                          volunteer.totalHours.toDouble()),
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 28,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    // Goal Hours
                                    const Text(
                                      'Semester Hour Goal',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      getTimeStringFromDouble(volunteer
                                          .semesterHourGoal
                                          .toDouble()),
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 28,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    volunteer.totalHours <
                                            volunteer.semesterHourGoal
                                        ? Text(
                                            '${((volunteer.totalHours / volunteer.semesterHourGoal) * 100).toStringAsFixed(1)}% complete! Keep going!',
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          )
                                        : const Text(
                                            'Goal Complete!',
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 28,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  )
                : Consumer(
                    builder: (context, ref, child) {
                      return AsyncValueWidget(
                          value: ref.watch(userOrgProvider),
                          loading: () => const CustomCircularLoader(),
                          error: (error, st) => ErrorResponseHandler(
                                error: error,
                                stackTrace: st,
                                retryCallback: () =>
                                    ref.refresh(userOrgProvider),
                              ),
                          data: (org) {
                            return Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Org Name
                                    Text(
                                      org.name,
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    CachedNetworkImage(
                                      imageUrl: org.profilePicPath!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Email
                                    Text(
                                      org.email,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                      Text(
                                      '${org.favorites.length.toString()} followers',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomTextButton(
                color: AppColors.primaryColor,
                onPressed: () {
                  AppRouter.pushNamed(Routes.EditProfileScreenRoute).then(
                    (value) {
                      if (value != null && value) {
                        if (authProv.currentUserRole == UserRole.VOLUNTEER) {
                          // ignore: unused_result
                          ref.refresh(userVolunteerProvider);
                        } else {
                          // ignore: unused_result
                          ref.refresh(userOrgProvider);
                        }
                      }
                    },
                  );
                },
                child: const Center(
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: CustomTextButton(
                color: AppColors.primaryColor,
                onPressed: () {
                  AppRouter.popUntilRoot();
                  ref.read(authProvider.notifier).logout();
                },
                child: const Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
