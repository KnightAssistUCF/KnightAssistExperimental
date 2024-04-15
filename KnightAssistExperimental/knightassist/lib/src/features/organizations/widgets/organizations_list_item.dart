import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/features/organizations/widgets/favorite_button.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/helpers/constants/constants.dart';

import '../../../config/routing/routing.dart';
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: org.backgroundPicPath!,
                        ),
                      ),
                    ),

                    // Organization profile image
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: org.profilePicPath!,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                          color: AppColors.textBlackColor,
                        ),
                      ),
                      Visibility(
                        visible: authProv.currentUserRole == UserRole.VOLUNTEER,
                        child: FavoriteButton(org: org),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlackColor,
                    ),
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
