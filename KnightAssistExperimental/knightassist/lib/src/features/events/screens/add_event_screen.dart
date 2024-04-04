import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

import '../../../config/routing/routing.dart';
import '../../../global/providers/all_providers.dart';
import '../../../global/states/edit_state.codegen.dart';
import '../../../global/widgets/custom_dialog.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../global/widgets/custom_text_field.dart';
import '../../../global/widgets/scrollable_column.dart';
import '../providers/events_provider.dart';

// TODO: Add tags
class AddEventScreen extends HookConsumerWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final authProv = ref.watch(authProvider.notifier);

    // Controllers
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final locationController = useTextEditingController();
    final maxVolunteersController = useTextEditingController();

    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.now();

    ref.listen<EditState>(
      eventStateProvider,
      (_, editState) => editState.maybeWhen(
        successful: () async {
          nameController.clear();
          descriptionController.clear();
          await showDialog<bool>(
              context: context,
              builder: (ctx) => CustomDialog.alert(
                    title: 'Add Event Success',
                    body: 'Event Added',
                    buttonText: 'OK',
                    onButtonPressed: () => AppRouter.pop(),
                  ));
        },
        failed: (reason) async {
          await showDialog<bool>(
            context: context,
            builder: (ctx) => CustomDialog.alert(
              title: 'Add Event Failed',
              body: reason,
              buttonText: 'Retry',
            ),
          );
        },
        orElse: () {},
      ),
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
                      'Add Event',
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
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          floatingText: 'Name',
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: descriptionController,
                          floatingText: 'Description',
                          multiline: true,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: locationController,
                          floatingText: 'Location',
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: maxVolunteersController,
                          floatingText: 'Max Volunteers',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        CustomTextButton(
                          color: AppColors.primaryColor,
                          child: const Center(
                            child: Text(
                              'Pick Start Time',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              onConfirm: (time) {
                                startTime = time;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextButton(
                          color: AppColors.primaryColor,
                          child: const Center(
                            child: Text(
                              'Pick End Time',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              onConfirm: (time) {
                                endTime = time;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )),

              // Confirm button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: CustomTextButton(
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      ref.read(eventsProvider).createEvent(
                          name: nameController.text,
                          description: descriptionController.text,
                          location: locationController.text,
                          sponsoringOrganization: authProv.currentUserId,
                          profilePicPath: '',
                          startTime: startTime,
                          endTime: endTime,
                          eventTags: [],
                          maxAttendees:
                              int.parse(maxVolunteersController.text));
                    }
                  },
                  child: Consumer(
                    builder: (context, ref, child) {
                      final eventState = ref.watch(eventStateProvider);
                      return eventState.maybeWhen(
                        processing: () => const Center(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
