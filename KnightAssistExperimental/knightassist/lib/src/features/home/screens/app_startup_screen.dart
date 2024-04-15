import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/routing/routing.dart';
import '../../../global/providers/all_providers.dart';
import '../../../global/states/auth_state.codegen.dart';

class AppStartupScreen extends HookConsumerWidget {
  const AppStartupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(
      authProvider,
      (_, authState) => authState.maybeWhen(
        authenticated: (_) => AppRouter.pushNamed(Routes.HomeScreenRoute),
        orElse: () => AppRouter.pushNamed(Routes.LoginScreenRoute),
      ),
    );

    return SizedBox.shrink();
  }
}
