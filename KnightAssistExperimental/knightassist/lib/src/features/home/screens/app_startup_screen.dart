import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/auth/screens/edit_profile_screen.dart';
import 'package:knightassist/src/features/auth/screens/profile_screen.dart';
import 'package:knightassist/src/features/events/screens/events_list_screen.dart';

import '../../../global/providers/all_providers.dart';
import '../../auth/screens/login_screen.dart';
import '../../qr/screens/qr_screen.dart';
import 'home_screen.dart';

class AppStartupScreen extends HookConsumerWidget {
  const AppStartupScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.maybeWhen(
      authenticated: (email) => HomeScreen(),
      orElse: () => const LoginScreen(),
    );
  }
}
