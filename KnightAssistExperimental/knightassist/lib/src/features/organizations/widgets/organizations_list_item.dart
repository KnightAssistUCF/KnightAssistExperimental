import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/features/volunteers/providers/volunteers_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/async_value_widget.dart';
import 'package:knightassist/src/global/widgets/custom_circular_loader.dart';
import 'package:knightassist/src/global/widgets/error_response_handler.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';
import 'package:knightassist/src/helpers/constants/constants.dart';

import '../../../config/routing/routing.dart';
import '../../../helpers/constants/app_styles.dart';
import '../models/organization_model.dart';
import '../providers/organizations_provider.dart';

class OrganizationsListItem extends ConsumerWidget {
  final OrganizationModel org;

  const OrganizationsListItem({
    super.key,
    required this.org,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    final imageProv = ref.watch(imagesProvider);
    final volProv = ref.watch(volunteersProvider);

    getProfileImage() {
      return FutureBuilder(
        future: imageProv.retrieveImage(type: '2', id: org.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data as String;
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: data,
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    getBackgroundImage() {
      return FutureBuilder(
        future: imageProv.retrieveImage(type: '4', id: org.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data as String;
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: data,
                  ),
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black26,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        color: AppColors.lightSkeletonColor,
        elevation: 5,
        child: InkResponse(
          onTap: () {
            ref.read(currentOrganizationProvider.notifier).state = org;
            AppRouter.pushNamed(Routes.OrganizationDetailsScreenRoute);
          },
          child: ClipRRect(
            borderRadius: Corners.rounded9,
            child: Column(
              children: [
                Stack(
                  children: [
                    getBackgroundImage(),

                    // Organization image
                    Positioned(
                      top: 15,
                      left: 5,
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          border: Border.all(width: 5, color: Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: getProfileImage(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        org.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Visibility(
                        visible: authProv.currentUserRole == UserRole.VOLUNTEER,
                        child: Consumer(
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
                                return IconButton(
                                  iconSize: 30,
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 4),
                                  icon: volunteer.favOrgIds.contains(org.id)
                                      ? const Icon(
                                          Icons.favorite,
                                          color: AppColors.secondaryColor,
                                        )
                                      : const Icon(
                                          Icons.favorite_outline,
                                          color: AppColors.secondaryColor,
                                        ),
                                  onPressed: () async {
                                    if (volunteer.favOrgIds.contains(org.id)) {
                                      await volProv.removeFavoriteOrg(
                                          orgId: org.id);
                                    } else {
                                      await volProv.addFavoriteOrg(
                                          orgId: org.id);
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: Text(
                    org.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
