import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';
import 'package:knightassist/src/helpers/form_validator.dart';

import '../../../global/states/auth_state.codegen.dart';
import '../../../global/widgets/custom_dialog.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../global/widgets/custom_text_field.dart';
import '../../../helpers/constants/app_colors.dart';

class RegisterVolunteerScreen extends HookConsumerWidget {
  const RegisterVolunteerScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController(text: '');
    final firstNameController = useTextEditingController(text: '');
    final lastNameController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final repeatPasswordController = useTextEditingController(text: '');

    void onAuthStateAuthenticated(String? currentUserEmail) {
      emailController.clear();
      firstNameController.clear();
      lastNameController.clear();
      passwordController.clear();
      repeatPasswordController.clear();
      AppRouter.popUntilRoot();
    }

    void onAuthStateFailed(String reason) async {
      await showDialog<bool>(
        context: context,
        builder: (ctx) {
          return CustomDialog.alert(
            title: 'Register Failed',
            body: reason,
            buttonText: 'Retry',
          );
        },
      );
    }

    ref.listen<AuthState>(
      authProvider,
      (previous, authState) async => authState.maybeWhen(
        authenticated: onAuthStateAuthenticated,
        failed: onAuthStateFailed,
        orElse: () {},
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ScrollableColumn(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Icon
                    InkResponse(
                      radius: 26,
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        size: 32,
                        color: Colors.white,
                      ),
                      onTap: () => AppRouter.pop(),
                    ),
                    const Text(
                      'Register Volunteer',
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
                    children: [
                      // Email
                      CustomTextField(
                        controller: emailController,
                        floatingText: 'Email',
                        hintText: 'user@example.com',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: FormValidator.emailValidator,
                      ),

                      const SizedBox(height: 20),

                      // First Name
                      CustomTextField(
                        controller: firstNameController,
                        floatingText: 'First Name',
                        hintText: 'John',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: FormValidator.nameValidator,
                      ),

                      const SizedBox(height: 20),

                      // Last Name
                      CustomTextField(
                        controller: lastNameController,
                        floatingText: 'Last Name',
                        hintText: 'Doe',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: FormValidator.nameValidator,
                      ),

                      const SizedBox(height: 20),

                      // Password
                      CustomTextField(
                        controller: passwordController,
                        floatingText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validator: FormValidator.passwordValidator,
                      ),

                      const SizedBox(height: 20),

                      // Repeat password
                      // TODO: Add logic to compare password fields
                      CustomTextField(
                        controller: repeatPasswordController,
                        floatingText: 'Repeat Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        validator: FormValidator.passwordValidator,
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: CustomTextButton(
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      ref.read(authProvider.notifier).registerVolunteer(
                            email: emailController.text,
                            password: passwordController.text,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                          );
                    }
                  },
                  child: Consumer(
                    builder: (context, ref, child) {
                      final authState = ref.watch(authProvider);
                      if (authState is AUTHENTICATING) {
                        return const Center(
                          child: SpinKitRing(
                            color: Colors.white,
                            size: 30,
                            lineWidth: 4,
                            duration: Duration(milliseconds: 1100),
                          ),
                        );
                      }
                      return child!;
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
