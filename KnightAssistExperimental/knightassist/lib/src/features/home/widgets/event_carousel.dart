import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';

class EventsCarousel extends StatefulHookConsumerWidget {
  final PageController imageController;
  final List<EventModel> events;

  const EventsCarousel({
    required this.imageController,
    required this.events,
  });

  @override
  _EventsCarouselState createState() => _EventsCarouselState();
}

class _EventsCarouselState extends ConsumerState<EventsCarousel> {
  late int _currentIndex;

  List<EventModel> get events => widget.events;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
