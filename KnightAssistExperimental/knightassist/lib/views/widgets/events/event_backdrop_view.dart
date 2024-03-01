import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../models/event_model.dart';
import '../../skeletons/event_image_placeholder.dart';

class EventBackdropView extends HookWidget {
  const EventBackdropView({
    Key? key,
    required this.backgroundImageController,
    required this.events,
  }) : super(key: key);

  final PageController backgroundImageController;
  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      controller: backgroundImageController,
      itemCount: events.length,
      itemBuilder: (ctx, i) => CachedNetworkImage(
        imageUrl: events[i].imageUrl,
        fit: BoxFit.cover,
        placeholder: (_, __) => const EventImagePlaceholder(
          childXAlign: Alignment.topCenter,
          padding: EdgeInsets.only(top: 110),
          iconSize: 85,
          borderRadius: 0,
        ),
        errorWidget: (_, __, Object? ___) => const EventImagePlaceholder(
          childXAlign: Alignment.topCenter,
          borderRadius: 0,
          iconSize: 85,
          padding: EdgeInsets.only(top: 110),
        ),
      ),
    );
  }
}
