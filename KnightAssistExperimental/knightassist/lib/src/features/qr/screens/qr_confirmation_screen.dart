import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/config/routing/routes.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';
import 'package:knightassist/src/features/qr/providers/qr_provider.dart';
import 'package:knightassist/src/features/qr/widgets/retry_scan_button.dart';
import 'package:knightassist/src/global/widgets/custom_circular_loader.dart';

import '../../../global/widgets/custom_text_button.dart';
import '../../../helpers/constants/constants.dart';
import '../../events/providers/events_provider.dart';

class QrConfirmationScreen extends StatelessWidget {
  final bool checkIn;
  final String eventId;

  const QrConfirmationScreen(
      {super.key, required this.checkIn, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.buttonGradientDanger,
            ),
            padding:
                EdgeInsets.only(bottom: Insets.bottomInsetsLow.height! + 5),
            child: Consumer(
              builder: (ctx, ref, child) {
                final state = ref.watch(qrStateProvider);
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 550),
                  switchInCurve: Curves.easeInBack,
                  child: state.maybeWhen(
                    loading: () => const CustomCircularLoader(),
                    data: (response) {
                      if (response is String) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Insets.expand,
                            const Icon(
                              Icons.cancel_outlined,
                              color: Colors.white,
                              size: 64,
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Text(
                                response,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            RetryScanButton(checkIn: checkIn, eventId: eventId),
                          ],
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Insets.expand,
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.white,
                            size: 64,
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              checkIn
                                  ? 'Checked in to ${(response as EventModel).name}'
                                  : 'Checked out of ${(response as EventModel).name}',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          checkIn
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: CustomTextButton(
                                    width: double.infinity,
                                    onPressed: () {
                                      ref.invalidate(qrStateProvider);
                                      AppRouter.popUntil(
                                          Routes.HomeScreenRoute);
                                    },
                                    color: AppColors.textWhite80Color,
                                    child: const Center(
                                      child: Text(
                                        'Return to Home',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 15,
                                          letterSpacing: 0.7,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: CustomTextButton(
                                    width: double.infinity,
                                    onPressed: () {
                                      ref.invalidate(qrStateProvider);
                                      ref
                                          .read(currentEventProvider.notifier)
                                          .state = response;
                                      AppRouter.popUntil(
                                          Routes.HomeScreenRoute);
                                      AppRouter.pushNamed(
                                          Routes.LeaveFeedbackScreenRoute);
                                    },
                                    color: AppColors.textWhite80Color,
                                    child: const Center(
                                      child: Text(
                                        'Leave Feedback',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 15,
                                          letterSpacing: 0.7,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      );
                    },
                    failed: (reason) => Column(
                      key: const ValueKey('error'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Insets.expand,
                        const Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 64,
                        ),
                        const SizedBox(height: 10),
                        const Expanded(
                          child: Text(
                            'QR Scan Failed',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        RetryScanButton(checkIn: checkIn, eventId: eventId),
                      ],
                    ),
                    orElse: () {},
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
