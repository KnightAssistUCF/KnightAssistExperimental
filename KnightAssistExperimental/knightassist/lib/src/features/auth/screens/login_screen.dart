import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/routing/app_router.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/custom_dialog.dart';
import 'package:knightassist/src/global/widgets/custom_text_field.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';

import '../../../config/routing/routes.dart';
import '../../../global/states/auth_state.codegen.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/form_validator.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    ref.listen<AuthState>(
      authProvider,
      (_, authState) => authState.maybeWhen(
        authenticated: (_) {
          emailController.clear();
          passwordController.clear();
          AppRouter.popUntilRoot();
        },
        failed: (reason) async {
          await showDialog<bool>(
            context: context,
            builder: (ctx) => CustomDialog.alert(
              title: 'Login Failed',
              body: reason,
              buttonText: 'Retry',
            ),
          );
        },
        orElse: () {},
      ),
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 28, 25, 20),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage('assets/KnightAssistCoA3.png'),
                      height: 60,
                    ),
                    const Center(
                      child: Text('welcome to',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ),
                    const Center(
                      child: Text('KnightAssist',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('easier volunteering is just a step away!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Email
                    CustomTextField(
                      controller: emailController,
                      floatingText: 'Email',
                      hintText: 'user@example.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: FormValidator.emailValidator,
                      showCursor: true,
                    ),

                    const SizedBox(height: 5),

                    // Password
                    CustomTextField(
                      controller: passwordController,
                      floatingText: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      validator: FormValidator.passwordValidator,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.pushNamed(Routes.ForgotPasswordScreenRoute);
                  },
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // Login Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: CustomTextButton(
                width: double.infinity,
                color: AppColors.primaryColor,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ref.read(authProvider.notifier).login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    final authState = ref.watch(authProvider);
                    return authState.maybeWhen(
                      authenticating: () => const Center(
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
                      'Login',
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

            const Row(children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              )),
              Text(
                "OR",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              )),
            ]),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 2),
              child: CustomTextButton(
                color: AppColors.primaryColor,
                child: const Center(
                  child: Text(
                    'Register as a Volunteer',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ),
                onPressed: () {
                  AppRouter.pushNamed(Routes.RegisterVolunteerScreenRoute);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
              child: CustomTextButton(
                color: AppColors.primaryColor,
                child: const Center(
                  child: Text(
                    'Register as an Organization',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ),
                onPressed: () {
                  AppRouter.pushNamed(Routes.RegisterOrgScreenRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
