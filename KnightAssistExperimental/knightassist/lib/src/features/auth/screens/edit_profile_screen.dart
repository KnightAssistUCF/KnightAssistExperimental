import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chip_list/chip_list.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/features/organizations/providers/organizations_provider.dart';
import 'package:knightassist/src/features/volunteers/providers/volunteers_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/custom_dialog.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';
import 'package:knightassist/src/helpers/constants/tags.dart';
import 'package:knightassist/src/helpers/form_validator.dart';

import '../../../global/states/future_state.codegen.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../global/widgets/custom_text_field.dart';
import '../../../helpers/constants/app_colors.dart';
import '../providers/auth_provider.dart';

class EditProfileScreen extends HookConsumerWidget {
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    final firstNameController =
        useTextEditingController(text: authProv.currentUserFirstName);
    final lastNameController =
        useTextEditingController(text: authProv.currentUserLastName);
    final orgNameController =
        useTextEditingController(text: authProv.currentUserOrgName);
    final emailController =
        useTextEditingController(text: authProv.currentUserEmail);
    // final currentPasswordController = useTextEditingController();
    // final newPasswordController = useTextEditingController();
    // final confirmNewPasswordController = useTextEditingController();
    late final _formKey = useMemoized(() => GlobalKey<FormState>());

    final List<String> userTags;
    final List<int> chosenTags = [];
    if (authProv.currentUserRole == UserRole.ORGANIZATION) {
      userTags = ref.watch(userOrgProvider).value!.categoryTags;
    } else {
      userTags = ref.watch(userVolunteerProvider).value!.categoryTags;
    }
    for (int i = 0; i < tags.length; i++) {
      if (userTags.contains(tags[i])) {
        chosenTags.add(i);
      }
    }

    ref.listen<FutureState<String>>(
      editProfileStateProvider,
      (previous, editProfileState) async {
        editProfileState.maybeWhen(
          data: (message) async {
            // currentPasswordController.clear();
            // newPasswordController.clear();
            // confirmNewPasswordController.clear();
            await showDialog<bool>(
              context: context,
              builder: (ctx) => CustomDialog.alert(
                title: 'Edit Profile Success',
                body: message,
                buttonText: 'OK',
                onButtonPressed: () => AppRouter.pop(true),
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
                      'Edit Profile',
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
                      (authProv.currentUserRole == UserRole.VOLUNTEER)
                          ? Column(
                              children: [
                                CustomTextField(
                                  controller: firstNameController,
                                  floatingText: 'First Name',
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  controller: lastNameController,
                                  floatingText: 'Last Name',
                                  textInputAction: TextInputAction.next,
                                ),
                              ],
                            )
                          : CustomTextField(
                              controller: orgNameController,
                              floatingText: 'Organization Name',
                              textInputAction: TextInputAction.next,
                            ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: emailController,
                        floatingText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: FormValidator.emailValidator,
                      ),
                      const SizedBox(height: 20),
                      /*
                      CustomTextField(
                        controller: currentPasswordController,
                        floatingText: 'Current Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validator: (inputPw) =>
                            FormValidator.currentPasswordValidator(
                                inputPw, authProv.currentUserPassword),
                      ),
                      const SizedBox(height: 20),
                    
                      CustomTextField(
                        controller: newPasswordController,
                        floatingText: 'New Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validator: (newPw) =>
                            FormValidator.newPasswordValidator(
                          newPw,
                          authProv.currentUserPassword,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      */
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

              // Save Button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: CustomTextButton(
                  color: AppColors.primaryColor,
                  width: double.infinity,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final List<String> newTags = [];
                      for (int i in chosenTags) {
                        newTags.add(tags[i]);
                      }

                      if (authProv.currentUserRole == UserRole.VOLUNTEER) {
                        final _volProv = ref.read(volunteersProvider);
                        _volProv.editVolunteer(
                          volunteerId: authProv.currentUserId,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          categoryTags: newTags,
                        );
                      } else {
                        final _orgProv = ref.read(organizationsProvider);
                        _orgProv.editOrg(
                          orgId: authProv.currentUserId,
                          name: orgNameController.text,
                          email: emailController.text,
                          categoryTags: newTags,
                        );
                      }
                    }
                  },
                  child: Consumer(
                    builder: (context, ref, child) {
                      final editProfileState =
                          ref.watch(editProfileStateProvider);
                      return editProfileState.maybeWhen(
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
