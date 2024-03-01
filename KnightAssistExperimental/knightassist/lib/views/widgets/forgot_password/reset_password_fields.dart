import 'package:flutter/material.dart';

import '../../../helper/utils/form_validator.dart';

import '../common/custom_textfield.dart';

class ResetPasswordFields extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;

  const ResetPasswordFields({
    Key? key,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: 'Type your password',
          floatingText: 'New Password',
          controller: newPasswordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: FormValidator.passwordValidator,
        ),
        const SizedBox(height: 25),
        CustomTextField(
          hintText: 'Retype your password',
          floatingText: 'Confirm Password',
          controller: confirmNewPasswordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: (confirmPw) => FormValidator.confirmPasswordValidator(
              confirmPw, newPasswordController.text),
        ),
      ],
    );
  }
}
