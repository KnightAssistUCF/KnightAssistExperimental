import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/custom_dialog.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';
import 'package:knightassist/src/helpers/form_validator.dart';

import '../../../global/states/future_state.codegen.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../global/widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';

class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    final firstNameController =
        useTextEditingController(text: authProv.currentUserFirstName);
    final lastNameController =
        useTextEditingController(text: authProv.currentUserLastName);
    final nameController =
        useTextEditingController(text: authProv.currentUserName);
    final emailController =
        useTextEditingController(text: authProv.currentUserEmail);
    final currentPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final confirmNewPasswordController = useTextEditingController();
    late final _formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen<FutureState<String>>(
      editProfileStateProvider,
      (previous, editProfileState) async {
        editProfileState.maybeWhen(
          data: (message) async {
            currentPasswordController.clear();
            newPasswordController.clear();
            confirmNewPasswordController.clear();
            await showDialog<bool>(
              context: context,
              builder: (ctx) => CustomDialog.alert(
                title: 'Edit Profile Success',
                body: message,
                buttonText: 'OK',
                onButtonPressed: () => AppRouter.pop(),
              ),
            );
          },
          failed: (reason) async => await showDialog<bool>(
            context: context,
            builder: (ctx) => CustomDialog.alert(
              title: 'Edit Profile Failed',
              body: reason,
              buttonText: 'Retry',
            ),
          ),
          orElse: () {},
        );
      },
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: Handle optional fields
                  (authProv.currentUserRole == UserRole.VOLUNTEER)
                      ? Column(
                          children: [
                            CustomTextField(
                              controller: firstNameController,
                              floatingText: 'First Name',
                              textInputAction: TextInputAction.next,
                            ),
                            CustomTextField(
                              controller: lastNameController,
                              floatingText: 'Last Name',
                              textInputAction: TextInputAction.next,
                            ),
                          ],
                        )
                      : CustomTextField(
                          controller: nameController,
                          floatingText: 'Name',
                          textInputAction: TextInputAction.next,
                        ),
                  CustomTextField(
                    controller: emailController,
                    floatingText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: FormValidator.emailValidator,
                  ),
                  CustomTextField(
                    controller: currentPasswordController,
                    floatingText: 'Current Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator: (inputPw) =>
                        FormValidator.currentPasswordValidator(
                            inputPw, authProv.currentUserPassword),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    controller: newPasswordController,
                    floatingText: 'New Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator: (newPw) => FormValidator.newPasswordValidator(
                      newPw,
                      authProv.currentUserPassword,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    controller: confirmNewPasswordController,
                    floatingText: 'Confirm New Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: (confirmPw) =>
                        FormValidator.confirmPasswordValidator(
                      confirmPw,
                      newPasswordController.text,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Save Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 2),
              child: CustomTextButton(
                width: double.infinity,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (authProv.currentUserRole == UserRole.VOLUNTEER) {
                      final _volProv = ref.read(volunteersProvider);
                      _volProv.editVolunteer(
                        volunteerId: authProv.currentUserId,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        password: newPasswordController.text,
                      );
                    } else {
                      final _orgProv = ref.read(organizationsProvider);
                      _orgProv.editOrg(
                        orgId: authProv.currentUserId,
                        name: nameController.text,
                        email: emailController.text,
                        password: newPasswordController.text,
                      );
                    }
                  }
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    final _editProfileState =
                        ref.watch(editProfileStateProvider);
                    return _editProfileState.maybeWhen(
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

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
