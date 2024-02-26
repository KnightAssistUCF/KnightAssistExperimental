import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../helper/utils/constants.dart';

import '../../../providers/auth_provider.dart';

import '../common/custom_text_button.dart';

class SavePasswordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SavePasswordButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton.gradient(
      width: double.infinity,
      onPressed: onPressed,
      gradient: Constants.buttonGradientGreen,
      child: Consumer(
        builder: (context, ref, child) {
          final _changePasswordState = ref.watch(changePasswordStateProvider);
          return _changePasswordState.maybeWhen(
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
    );
  }
}
