import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../helper/utils/form_validator.dart';

import '../../../providers/all_providers.dart';

import '../common/custom_textfield.dart';

class ChangePasswordFields extends ConsumerWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;

  const ChangePasswordFields({
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          hintText: 'Enter current password',
          floatingText: 'Current Password',
          controller: currentPasswordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: (inputPw) => FormValidator.currentPasswordValidator(
            inputPw,
            authProv.currentUserPassword,
          ),
        ),
        const SizedBox(height: 25),
        CustomTextField(
          hintText: 'Type your password',
          floatingText: 'New Password',
          controller: newPasswordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: (newPw) => FormValidator.newPasswordValidator(
            newPw,
            authProv.currentUserPassword,
          ),
        ),
        const SizedBox(height: 25),
        CustomTextField(
          hintText: 'Retype your password',
          floatingText: 'New Password',
          controller: confirmNewPasswordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: (confirmPw) => FormValidator.confirmPasswordValidator(
            confirmPw,
            newPasswordController.text,
          ),
        ),
      ],
    );
  }
}
