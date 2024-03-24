import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/routing/routing.dart';
import '../../../global/providers/all_providers.dart';
import '../../../global/states/edit_state.codegen.dart';
import '../../../global/widgets/custom_dialog.dart';
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    floatingText: 'Name',
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    controller: descriptionController,
                    floatingText: 'Description',
                    multiline: true,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Confirm button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: CustomTextButton(
                width: double.infinity,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ref.read(eventsProvider).editEvent(
                        event: event,
                        name: nameController.text,
                        description: descriptionController.text);
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
    );
  }
}
