import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/organizations/models/organization_model.dart';

import '../../../global/providers/all_providers.dart';
import '../../../global/widgets/async_value_widget.dart';
import '../../../global/widgets/custom_circular_loader.dart';
import '../../../global/widgets/error_response_handler.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../volunteers/providers/volunteers_provider.dart';

class FavoriteButton extends StatefulHookConsumerWidget {
  final OrganizationModel org;

  const FavoriteButton({required this.org});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    final volProv = ref.watch(volunteersProvider);
    bool isFavorite = false;

    return AsyncValueWidget(
      value: ref.watch(userVolunteerProvider),
      loading: () => const CustomCircularLoader(),
      error: (error, st) => ErrorResponseHandler(
        error: error,
        stackTrace: st,
        retryCallback: () => ref.refresh(userVolunteerProvider),
      ),
      data: (volunteer) {
        isFavorite = volunteer.favOrgIds.contains(widget.org.id);
        return IconButton(
          iconSize: 30,
          padding: const EdgeInsets.only(left: 4, right: 4),
          icon: isFavorite
              ? const Icon(
                  Icons.favorite,
                  color: AppColors.secondaryColor,
                )
              : const Icon(
                  Icons.favorite_outline,
                  color: AppColors.secondaryColor,
                ),
          onPressed: () async {
            if (volunteer.favOrgIds.contains(widget.org.id)) {
              await volProv.removeFavoriteOrg(orgId: widget.org.id);
              setState(() {
                isFavorite = false;
                // ignore: unused_result
                ref.refresh(userVolunteerProvider);
              });
            } else {
              await volProv.addFavoriteOrg(orgId: widget.org.id);
              setState(() {
                isFavorite = true;
                // ignore: unused_result
                ref.refresh(userVolunteerProvider);
              });
            }
          },
        );
      },
    );
  }
}
