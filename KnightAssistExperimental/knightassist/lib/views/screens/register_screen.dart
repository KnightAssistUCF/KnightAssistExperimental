import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/enums/user_role_enum.dart';

import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';
import '../../helper/utils/form_validator.dart';

import '../../providers/all_providers.dart';

import '../../providers/states/auth_state.dart';

import '../../routes/app_router.dart';

import '../widgets/common/custom_dialog.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/rounded_bottom_container.dart';
import '../widgets/common/scrollable_column.dart';

class RegisterScreen extends StatefulHookConsumerWidget {
  const RegisterScreen();

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool _formHasData = false;
  late final formKey = GlobalKey<FormState>();

  Future<bool> _showConfirmDialog() async {
    if (_formHasData) {
      final doPop = await showDialog<bool>(
        context: context,
        barrierColor: Constants.barrierColor,
        builder: (ctx) => const CustomDialog.confirm(
          title: 'Are you sure?',
          body: 'Do you want to go back without saving your form data?',
          trueButtonText: 'Yes',
          falseButtonText: 'No',
        ),
      );
      if (doPop == null || !doPop) return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  CustomTextButton buildNextButton(ValueNotifier<bool> userDetailsState) {
    return CustomTextButton.outlined(
      width: double.infinity,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          userDetailsState.value = false;
        }
      },
      padding: const EdgeInsets.only(left: 20, right: 15),
      border: Border.all(color: Constants.primaryColor, width: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Next',
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 15,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Arrow
          Icon(
            Icons.arrow_forward_sharp,
            size: 26,
            color: Constants.primaryColor,
          )
        ],
      ),
    );
  }

  CustomTextButton buildVolunteerConfirmButton({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          ref.read(authProvider.notifier).registerVolunteer(
              email: email,
              password: password,
              firstName: firstName,
              lastName: lastName);
        }
      },
      gradient: Constants.buttonGradientGreen,
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
            'CONFIRM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  CustomTextButton buildOrganizationConfirmButton({
    required String name,
    required String email,
    required String password,
  }) {
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          ref.read(authProvider.notifier).registerOrganization(
              email: email, password: password, name: name);
        }
      },
      gradient: Constants.buttonGradientGreen,
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
            'CONFIRM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  VoidCallback? onBackTap(ValueNotifier<bool> userDetailsState) {
    if (!userDetailsState.value) return () => userDetailsState.value = true;
  }

  void onFormChanged() {
    if (!_formHasData) _formHasData = true;
  }

  void onAuthStateFailed(String reason) async {
    await showDialog<bool>(
      context: context,
      barrierColor: Constants.barrierColor.withOpacity(0.75),
      builder: (ctx) {
        return CustomDialog.alert(
          title: 'Register Failed',
          body: reason,
          buttonText: 'Retry',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsState = useState<bool>(true);
    final isVolunteerState = useState<bool>(true);
    final emailController = useTextEditingController(text: '');
    final firstNameController = useTextEditingController(text: '');
    final lastNameController = useTextEditingController(text: '');
    final orgNameController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final confirmPasswordController = useTextEditingController(text: '');

    void onAuthStateAuthenticated(String? currentUserName) {
      emailController.clear();
      passwordController.clear();
      firstNameController.clear();
      lastNameController.clear();
      orgNameController.clear();
      confirmPasswordController.clear();
      _formHasData = false;
      AppRouter.popUntilRoot();
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollableColumn(
          children: [
            Form(
              key: formKey,
              onChanged: onFormChanged,
              onWillPop: _showConfirmDialog,
              child: RoundedBottomContainer(
                onBackTap: onBackTap(userDetailsState),
                children: [
                  Text(
                    'Register',
                    style: context.headline3.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (userDetailsState.value)
                    if (isVolunteerState.value)
                      _VolunteerDetailFields(
                          emailController: emailController,
                          firstNameController: firstNameController,
                          lastNameController: lastNameController)
                    else
                      _OrganizationDetailFields(
                          emailController: emailController,
                          orgNameController: orgNameController)
                  else
                    _PasswordDetailFields(
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                    ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                40,
                20,
                Constants.bottomInsets,
              ),
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 550),
                  switchOutCurve: Curves.easeInBack,
                  child: userDetailsState.value
                      ? buildNextButton(userDetailsState)
                      : isVolunteerState.value
                          ? buildVolunteerConfirmButton(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              password: passwordController.text)
                          : buildOrganizationConfirmButton(
                              name: orgNameController.text,
                              email: emailController.text,
                              password: passwordController.text)),
            )
          ],
        ),
      ),
    );
  }
}

class _VolunteerDetailFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const _VolunteerDetailFields({
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First name
        CustomTextField(
          controller: firstNameController,
          floatingText: 'First Name',
          hintText: 'Type your first name',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: FormValidator.nameValidator,
        ),

        const SizedBox(height: 25),

        // Last name
        CustomTextField(
          controller: lastNameController,
          floatingText: 'Last Name',
          hintText: 'Type your last name',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: FormValidator.nameValidator,
        ),

        const SizedBox(height: 25),

        // Email
        CustomTextField(
          controller: emailController,
          floatingText: 'Email',
          hintText: 'Type your email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          validator: FormValidator.emailValidator,
        ),
      ],
    );
  }
}

class _OrganizationDetailFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController orgNameController;

  const _OrganizationDetailFields({
    required this.emailController,
    required this.orgNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name
        CustomTextField(
          controller: orgNameController,
          floatingText: 'Organization Name',
          hintText: 'Type your organization\'s name',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: FormValidator.nameValidator,
        ),

        const SizedBox(height: 25),

        // Email
        CustomTextField(
          controller: emailController,
          floatingText: 'Email',
          hintText: 'Type your email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          validator: FormValidator.emailValidator,
        ),
      ],
    );
  }
}

class _PasswordDetailFields extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const _PasswordDetailFields({
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Password
        CustomTextField(
          controller: passwordController,
          autofocus: true,
          floatingText: 'Password',
          hintText: 'Type your password',
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: FormValidator.passwordValidator,
        ),

        const SizedBox(height: 25),

        // Confirm password
        CustomTextField(
          controller: confirmPasswordController,
          floatingText: 'Confirm password',
          hintText: 'Retype your password',
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: (confirmPw) => FormValidator.confirmPasswordValidator(
            confirmPw,
            passwordController.text,
          ),
        ),
      ],
    );
  }
}
