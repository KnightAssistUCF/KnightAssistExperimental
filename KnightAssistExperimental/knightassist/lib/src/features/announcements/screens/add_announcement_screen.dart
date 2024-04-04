import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

import '../../../config/routing/routing.dart';
import '../../../global/states/future_state.codegen.dart';
import '../../../global/widgets/custom_dialog.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../global/widgets/custom_text_field.dart';
import '../../../helpers/constants/app_colors.dart';
import '../providers/announcements_provider.dart';

class AddAnnouncementScreen extends HookConsumerWidget {
  const AddAnnouncementScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);

    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    late final _formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen<FutureState<String>>(
      announcementStateProvider,
      (previous, editAnnouncementState) async {
        editAnnouncementState.maybeWhen(
          data: (message) async {
            titleController.clear();
            contentController.clear();
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
          child: Column(
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
                      'Add Announcement',
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: titleController,
                        floatingText: 'Title',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: contentController,
                        floatingText: 'Content',
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ),

              // Save Button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 2),
                child: CustomTextButton(
                  color: AppColors.primaryColor,
                  width: double.infinity,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final annProv = ref.read(announcementsProvider);
                      await annProv.createAnnouncement(
                          orgId: authProv.currentUserId,
                          title: titleController.text,
                          content: contentController.text);
                    }
                  },
                  child: Consumer(
                    builder: (context, ref, child) {
                      final _announcementState =
                          ref.watch(announcementStateProvider);
                      return _announcementState.maybeWhen(
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
                        'Save',
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
