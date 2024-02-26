import 'package:flutter/material.dart';

import '../views/screens/app_startup_screen.dart';
import '../views/screens/change_password_screen.dart';
import '../views/screens/forgot_password_screen.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/login_screen.dart';
import '../views/screens/profile_screen.dart';
import 'routes.dart';

@immutable
class AppRouter {
  const AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String initialRoute = Routes.AppStartupScreenRoute;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.AppStartupScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const AppStartupScreen(),
          settings: const RouteSettings(name: Routes.AppStartupScreenRoute),
        );
      case Routes.HomeScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomeScreen(),
          settings: const RouteSettings(name: Routes.HomeScreenRoute),
        );
      case Routes.LoginScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginScreen(),
          settings: const RouteSettings(name: Routes.LoginScreenRoute),
        );
      case Routes.RegisterScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const RegisterScreen(),
          settings: const RouteSettings(name: Routes.RegisterScreenRoute),
        );
      case Routes.ForgotPasswordScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ForgotPasswordScreen(),
          settings: const RouteSettings(name: Routes.ForgotPasswordScreenRoute),
        );
      case Routes.ChangePasswordScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ChangePasswordScreen(),
          settings: const RouteSettings(name: Routes.ChangePasswordScreenRoute),
        );
      case Routes.ProfileScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ProfileScreen(),
          settings: const RouteSettings(name: Routes.ProfileScreenRoute),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Unknown Route'),
        ),
        body: const Center(
          child: Text('Unknown Route'),
        ),
      ),
    );
  }

  static Future<dynamic> pushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  static Future<void> pop([dynamic result]) async {
    navigatorKey.currentState!.pop(result);
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static void popUntilRoot() {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(initialRoute));
  }
}
