import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/providers/events_provider.dart';
import 'package:knightassist/views/widgets/events/white_event_container.dart';

import '../../../helper/utils/constants.dart';
import '../../../models/event_model.dart';
import '../../../routes/app_router.dart';
import '../../../routes/routes.dart';

class EventsCarousel extends StatefulHookConsumerWidget {
  final PageController backgroundImageController;
  final List<EventModel> events;

  const EventsCarousel({
    required this.backgroundImageController,
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
    useEffect(() {
      _currentIndex = events.length ~/ 2;
    }, const []);
    return CarouselSlider.builder(
      carouselController: CarouselController(),
      options: getCarouselOptions(),
      itemCount: events.length,
      itemBuilder: (ctx, i, _) => WhiteEventContainer(
        isCurrent: _currentIndex == i,
        event: events[i],
        onViewDetails: () {
          final leftIndex = (i - 1) % events.length;
          final rightIndex = (i + 1) % events.length;
          ref.read(selectedEventProvider.state).update((_) => events[i]);
          ref
              .read(leftEventProvider.state)
              .update((state) => events[leftIndex]);
          ref
              .read(rightEventProvider.state)
              .update((state) => events[rightIndex]);
          AppRouter.pushNamed(Routes.EventDetailsScreenRoute);
        },
      ),
    );
  }

  CarouselOptions getCarouselOptions() {
    return CarouselOptions(
      scrollPhysics: const BouncingScrollPhysics(),
      enableInfiniteScroll: false,
      viewportFraction: 0.62,
      aspectRatio: 0.68,
      enlargeCenterPage: true,
      enlargeStrategy: CenterPageEnlargeStrategy.height,
      initialPage: _currentIndex,
      onScrolled: (offset) {},
      onPageChanged: (i, reason) {
        setState(() {
          _currentIndex = i;
        });
        widget.backgroundImageController.animateToPage(
          i,
          curve: Curves.easeOutCubic,
          duration: Constants.defaultAnimationDuration,
        );
      },
    );
  }
}
