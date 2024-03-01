import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/views/skeletons/events_skeleton_loader.dart';

import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';

import '../../providers/all_providers.dart';
import '../../providers/events_provider.dart';

import '../../routes/app_router.dart';
import '../widgets/common/error_response_handler.dart';
import '../widgets/events/event_backdrop_view.dart';
import '../widgets/events/events_carousel.dart';
import '../widgets/events/events_icons_row.dart';

class EventsScreen extends HookConsumerWidget {
  const EventsScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = context.screenHeight;
    final events = ref.watch(eventsFuture);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 550),
        switchOutCurve: Curves.easeInBack,
        child: events.when(
          data: (events) {
            final backgroundImageController = usePageController(
              initialPage: events.length ~/ 2,
            );
            return SizedBox.expand(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // page controller background
                  Positioned.fill(
                    child: EventBackdropView(
                      backgroundImageController: backgroundImageController,
                      events: events,
                    ),
                  ),

                  // top black overlay
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 110,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: Constants.blackOverlayGradient,
                      ),
                    ),
                  ),

                  // Events carousel
                  Positioned(
                    bottom: -50,
                    top: screenHeight * 0.27,
                    child: EventsCarousel(
                      backgroundImageController: backgroundImageController,
                      events: events,
                    ),
                  ),

                  // Icons row
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: EventsIconsRow(),
                  )
                ],
              ),
            );
          },
          loading: () => const EventsSkeletonLoader(),
          error: (error, st) => ErrorResponseHandler(
            error: error,
            stackTrace: st,
            retryCallback: () => ref.refresh(eventsFuture),
            onError: () {
              ref.read(authProvider.notifier).logout();
              AppRouter.popUntilRoot();
            },
          ),
        ),
      ),
    );
  }
}
