import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';
import 'package:knightassist/src/helpers/constants/tags.dart';
import 'package:knightassist/src/helpers/extensions/datetime_extension.dart';

import '../../../config/routing/routing.dart';
import '../../../global/providers/all_providers.dart';
import '../../../global/states/edit_state.codegen.dart';
import '../../../global/widgets/custom_dialog.dart';
import '../../../global/widgets/custom_text.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../global/widgets/custom_text_field.dart';
import '../../../global/widgets/scrollable_column.dart';
import '../providers/events_provider.dart';

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
    final maxVolunteersController =
        useTextEditingController(text: event.maxAttendees.toString());

    DateTime startTime = event.startTime;
    DateTime endTime = event.endTime;

    final List<int> chosenTags = [];

    for (int i = 0; i < tags.length; i++) {
      if (event.eventTags.contains(tags[i])) {
        chosenTags.add(i);
      }
    }

    final ImagePicker _picker = ImagePicker();
    File? _image;

    ref.listen<EditState>(
      eventStateProvider,
      (_, editState) => editState.maybeWhen(
        successful: () {
          nameController.clear();
          descriptionController.clear();
          ref.refresh(eventsProvider);
          AppRouter.popUntil(Routes.EventsListScreenRoute);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                            children: [
                              Container(
                                width: double.infinity,
                                constraints: const BoxConstraints(
                                    maxHeight: 250, minHeight: 200),
                                child: (_image != null)
                                    ? Image(image: FileImage(_image!))
                                    : CachedNetworkImage(
                                        imageUrl: event.profilePicPath,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: CustomTextButton(
                                  color: AppColors.primaryColor,
                                  padding: const EdgeInsets.all(10),
                                  onPressed: () async {
                                    final pickedImage = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50);
                                    if (pickedImage == null) {
                                      return;
                                    }
                                    final File fileImage =
                                        File(pickedImage.path);
                                    setState(() {
                                      _image = fileImage;
                                    });
                                  },
                                  child: const Center(
                                    child: Text(
                                      'Pick Image',
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
                            ],
                          );
                        },
                      ),
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
                      StatefulBuilder(
                        builder: (context, setState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'Start: ${startTime.toDateString()}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    DatePicker.showDateTimePicker(
                                      currentTime: event.startTime,
                                      context,
                                      onConfirm: (time) {
                                        setState(() => startTime = time.toLocal());
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit))
                            ],
                          );
                        },
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'End: ${endTime.toDateString()}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  DatePicker.showDateTimePicker(
                                    currentTime: event.endTime,
                                    context,
                                    onConfirm: (time) {
                                      setState(() => endTime = time.toLocal());
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        );
                      }),
                      const SizedBox(height: 20),
                      const Text(
                        'Choose Content Tags',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ChipList(
                          listOfChipNames: tags,
                          supportsMultiSelect: true,
                          activeBgColorList: const [AppColors.primaryColor],
                          activeTextColorList: const [
                            AppColors.textWhite80Color
                          ],
                          inactiveTextColorList: const [
                            AppColors.textBlackColor
                          ],
                          shouldWrap: true,
                          listOfChipIndicesCurrentlySeclected: chosenTags,
                          runSpacing: 2,
                          spacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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

                      final List<String> newTags = [];
                      for (int i in chosenTags) {
                        newTags.add(tags[i]);
                      }

                      await ref.read(eventsProvider).editEvent(
                            eventId: event.id,
                            orgId: event.sponsoringOrganizationId,
                            name: nameController.text,
                            description: descriptionController.text,
                            startTime: startTime.toUtc(),
                            endTime: endTime.toUtc(),
                            eventTags: newTags,
                            maxAttendees:
                                int.parse(maxVolunteersController.text),
                          );

                      await ref
                          .read(imagesProvider)
                          .storeImage(type: "1", id: event.id, file: _image!);
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
