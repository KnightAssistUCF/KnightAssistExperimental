import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/utils/form_validator.dart';

import '../../../providers/all_providers.dart';

import '../common/custom_textfield.dart';
import 'otp_code_fields.dart';
import 'reset_password_fields.dart';

class ForgotTextFields extends StatefulHookConsumerWidget {
  const ForgotTextFields({
    Key? key,
    required this.emailController,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;

  @override
  _ForgotPasswordFieldsState createState() => _ForgotPasswordFieldsState();
}

class _ForgotPasswordFieldsState extends ConsumerState<ForgotTextFields> {
  late Widget currentTextFields;

  @override
  Widget build(BuildContext context) {
    final _forgotPasswordState = ref.watch(forgotPasswordProvider);
    return _forgotPasswordState.maybeWhen(
      email: () {
        currentTextFields = CustomTextField(
          controller: widget.emailController,
          floatingText: 'Email',
          hintText: 'Type your email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FormValidator.emailValidator,
        );
        return currentTextFields;
      },
      otp: (_) {
        currentTextFields = const OtpCodeFields();
        return currentTextFields;
      },
      resetPassword: (_) {
        currentTextFields = ResetPasswordFields(
          newPasswordController: widget.newPasswordController,
          confirmNewPasswordController: widget.confirmNewPasswordController,
        );
        return currentTextFields;
      },
      success: (_) => const SizedBox.shrink(),
      orElse: () => currentTextFields,
    );
  }
}
