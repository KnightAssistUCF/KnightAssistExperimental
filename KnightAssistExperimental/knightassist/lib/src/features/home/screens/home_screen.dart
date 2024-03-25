import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/config/routing/routes.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/error_response_handler.dart';

import '../../events/providers/events_provider.dart';
import '../skeletons/event_carousel_skeleton_loader.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsFuture);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 65),
            // App bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Burger menu

                // Profile Icon
                InkResponse(
                  radius: 26,
                  child: const Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 30,
                  ),
                  onTap: () {
                    AppRouter.pushNamed(Routes.ProfileScreenRoute);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Event carousel
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 550),
              switchOutCurve: Curves.easeInBack,
              child: events.when(
                data: (events) {},
                loading: () => const EventCarouselSkeletonLoader(),
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
            )
          ],
        ),
      ),
    );
  }
}
