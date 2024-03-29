import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/routing/routing.dart';
import '../../../global/widgets/custom_network_image.dart';
import '../../../global/widgets/list_image_placeholder.dart';
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
    return InkResponse(
      onTap: () {
        ref.read(currentOrganizationProvider.notifier).state = org;
        AppRouter.pushNamed(Routes.OrganizationDetailsScreenRoute);
      },
      child: ClipRRect(
        borderRadius: Corners.rounded9,
        child: SizedBox(
          height: 230,
          child: Stack(
            children: [
              // Organization image
              Positioned.fill(
                child: CustomNetworkImage(
                  fit: BoxFit.cover,
                  borderRadius: Corners.none,
                  imageUrl: org.profilePicPath,
                  placeholder: const ListImagePlaceholder(),
                  errorWidget: const ListImagePlaceholder(),
                ),
              ),
              // Details
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
