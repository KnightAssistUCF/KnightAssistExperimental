import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/auth/screens/login_screen.dart';
import 'package:knightassist/src/features/home/screens/home_screen.dart';

import '../../../global/providers/all_providers.dart';

class AppStartupScreen extends HookConsumerWidget {
  const AppStartupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.maybeWhen(
      authenticated: (email) => HomeScreen(),
      orElse: () => const LoginScreen(),
    );
  }
}
