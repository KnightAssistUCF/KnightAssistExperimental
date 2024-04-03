import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/routing/routing.dart';
import '../../features/auth/enums/user_role_enum.dart';
import '../../features/organizations/models/organization_model.dart';
import '../../features/organizations/providers/organizations_provider.dart';
import '../../features/volunteers/models/volunteer_model.dart';
import '../../features/volunteers/providers/volunteers_provider.dart';
import '../../helpers/constants/app_colors.dart';
import '../providers/all_providers.dart';
import 'async_value_widget.dart';
import 'custom_circular_loader.dart';
import 'error_response_handler.dart';

class CustomTopBar extends HookConsumerWidget {
  const CustomTopBar(
      {super.key, required this.scaffoldKey, required this.title});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Drawer icon
          InkResponse(
            radius: 26,
            child: const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 15),
              child: Icon(
                Icons.menu,
                size: 32,
                color: Colors.white,
              ),
            ),
            onTap: () => scaffoldKey.currentState!.openDrawer(),
          ),

          // Page Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Profile Icon
          InkResponse(
            radius: 26,
            child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 15),
                child: AsyncValueWidget(
                  value: (authProv.currentUserRole == UserRole.VOLUNTEER)
                      ? ref.watch(userVolunteerProvider)
                      : ref.watch(userOrgProvider),
                  loading: () => const CustomCircularLoader(
                    color: Colors.white,
                  ),
                  error: (error, st) => ErrorResponseHandler(
                    error: error,
                    stackTrace: st,
                    retryCallback: () =>
                        (authProv.currentUserRole == UserRole.VOLUNTEER)
                            ? ref.refresh(userVolunteerProvider)
                            : ref.refresh(userOrgProvider),
                  ),
                  data: (user) {
                    return CachedNetworkImage(
                      imageUrl: (authProv.currentUserRole == UserRole.VOLUNTEER)
                          ? (user as VolunteerModel).profilePicPath!
                          : (user as OrganizationModel).profilePicPath!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                )),
            onTap: () {
              AppRouter.pushNamed(Routes.ProfileScreenRoute);
            },
          ),
        ],
      ),
    );
  }
}
