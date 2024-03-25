import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../config/routing/app_router.dart';
import '../../../../config/routing/routes.dart';
import '../../../../global/widgets/custom_network_image.dart';
import '../../../../global/widgets/list_image_placeholder.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../models/event_model.codegen.dart';
import '../../providers/events_provider.dart';

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
              // Event image
              Positioned.fill(
                child: CustomNetworkImage(
                  fit: BoxFit.cover,
                  borderRadius: Corners.none,
                  // TODO: Set up image provider
                  imageUrl: '',
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
