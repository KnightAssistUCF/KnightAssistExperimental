import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:knightassist/views/skeletons/event_image_placeholder.dart';
import 'package:knightassist/views/widgets/common/custom_text_button.dart';

import '../../../helper/utils/constants.dart';

import '../../../models/event_model.dart';

import '../common/custom_network_image.dart';
import 'event_overview_column.dart';

class WhiteEventContainer extends HookWidget {
  const WhiteEventContainer({
    Key? key,
    required this.isCurrent,
    required this.event,
    required this.onViewDetails,
  }) : super(key: key);

  final EventModel event;
  final bool isCurrent;
  final VoidCallback onViewDetails;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Constants.defaultAnimationDuration,
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: isCurrent ? Colors.white : Colors.white54,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, Constants.bottomInsetsLow),
      child: LayoutBuilder(
        builder: (ctx, constraints) => Column(
          children: [
            CustomNetworkImage(
              imageUrl: event.imageUrl,
              height: constraints.minHeight * 0.58,
              fit: BoxFit.fill,
              onTap: onViewDetails,
              placeholder: EventImagePlaceholder(
                height: constraints.minHeight * 0.58,
              ),
              errorWidget: EventImagePlaceholder(
                height: constraints.minHeight * 0.58,
              ),
            ),
            const SizedBox(height: 10),
            if (isCurrent) ...[
              EventOverviewColumn(event: event),
              const Spacer(),
              CustomTextButton(
                color: Constants.scaffoldColor,
                onPressed: onViewDetails,
                child: const Center(
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
