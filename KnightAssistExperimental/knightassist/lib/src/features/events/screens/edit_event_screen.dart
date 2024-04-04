import 'package:flutter/material.dart';
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
class EditEventScreen extends HookConsumerWidget {
  const EditEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final event = ref.watch(currentEventProvider);

    // Controllers
    final nameController = useTextEditingController(text: event!.name);
    final descriptionController =
        useTextEditingController(text: event.description);
    final locationController = useTextEditingController(text: event.location);
    final startTimeController =
        useTextEditingController(text: event.startTime.toIso8601String());
    final endTimeController =
        useTextEditingController(text: event.endTime.toIso8601String());
    final maxVolunteersController =
        useTextEditingController(text: event.maxAttendees.toString());

    _selectStartTime() async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.parse(startTimeController.text),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));
      if (picked != null &&
          picked != DateTime.parse(startTimeController.text)) {
        startTimeController.text = picked.toIso8601String();
      }
    }

    _selectEndTime() async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.parse(endTimeController.text),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));
      if (picked != null && picked != DateTime.parse(endTimeController.text)) {
        endTimeController.text = picked.toIso8601String();
      }
    }

    ref.listen<EditState>(
      eventStateProvider,
      (_, editState) => editState.maybeWhen(
        successful: () {
          nameController.clear();
          descriptionController.clear();
          AppRouter.pop();
        },
        failed: (reason) async {
          await showDialog<bool>(
            context: context,
            builder: (ctx) => CustomDialog.alert(
              title: 'Edit Event Failed',
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
                      'Edit Event',
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
                          controller: startTimeController,
                          floatingText: 'Start Time',
                          textInputAction: TextInputAction.next,
                          suffix: IconButton(
                            color: Colors.black,
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _selectStartTime(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: endTimeController,
                          floatingText: 'End Time',
                          textInputAction: TextInputAction.next,
                          suffix: IconButton(
                            color: Colors.black,
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _selectEndTime(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: maxVolunteersController,
                          floatingText: 'Max Volunteers',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        )
                      ],
                    ),
                  )),

              const Spacer(),

              // Confirm button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: CustomTextButton(
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      ref.read(eventsProvider).editEvent(
                            eventId: event.id,
                            orgId: event.sponsoringOrganizationId,
                            name: nameController.text,
                            description: descriptionController.text,
                          );
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
