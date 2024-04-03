import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/features/events/providers/events_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';
import 'package:knightassist/src/global/widgets/custom_dialog.dart';
import 'package:knightassist/src/global/widgets/custom_text_button.dart';
import 'package:knightassist/src/global/widgets/custom_text_field.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';

import '../../../helpers/constants/app_colors.dart';
import '../providers/feedback_provider.dart';

class LeaveFeedbackScreen extends HookConsumerWidget {
  const LeaveFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(currentEventProvider);
    final textController = useTextEditingController();
    late final _formKey = useMemoized(() => GlobalKey<FormState>());

    num _rating = 3;

    ref.listen<FutureState<String>>(
      feedbackStateProvider,
      (previous, feedbackState) async {
        feedbackState.maybeWhen(
          data: (message) async {
            textController.clear();
            await showDialog<bool>(
              context: context,
              builder: (ctx) => CustomDialog.alert(
                title: 'Success',
                body: message,
                buttonText: 'OK',
                onButtonPressed: () => AppRouter.pop(),
              ),
            );
          },
          failed: (reason) async => await showDialog<bool>(
            context: context,
            builder: (ctx) => CustomDialog.alert(
              title: 'Failed',
              body: reason,
              buttonText: 'Retry',
            ),
          ),
          orElse: () {},
        );
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ScrollableColumn(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkResponse(
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        size: 32,
                        color: Colors.white,
                      ),
                      onTap: () => AppRouter.pop(),
                    ),
                    const Text(
                      'Leave Feedback',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          _rating = rating;
                        },
                      ),
                      const SizedBox(height: 15),
                      // TODO: Improve text field
                      CustomTextField(
                        controller: textController,
                        floatingText: 'Feedback',
                        multiline: true,
                        expands: true,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),

              // Submit Button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
                child: CustomTextButton(
                  color: AppColors.primaryColor,
                  width: double.infinity,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ref.read(feedbackProvider).create(
                            eventId: event!.id,
                            rating: _rating as double,
                            content: textController.text,
                          );
                    }
                  },
                  child: Consumer(
                    builder: (context, ref, child) {
                      final feedbackState = ref.watch(feedbackStateProvider);
                      return feedbackState.maybeWhen(
                        loading: () => const Center(
                          child: SpinKitRing(
                            color: Colors.white,
                            size: 30,
                            lineWidth: 4,
                            duration: Duration(milliseconds: 1100),
                          ),
                        ),
                        orElse: () => child!,
                      );
                    },
                    child: const Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
