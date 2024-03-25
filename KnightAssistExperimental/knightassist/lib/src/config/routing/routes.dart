// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/profile_screen.dart';
import '../../features/auth/screens/register_organization_screen.dart';
import '../../features/auth/screens/register_volunteer_screen.dart';
import '../../features/events/screens/edit_event_screen.dart';
import '../../features/events/screens/event_details_screen.dart';
import '../../features/events/screens/events_list_screen.dart';
import '../../features/home/screens/app_startup_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/organizations/screens/edit_organization_screen.dart';
import '../../features/organizations/screens/organization_details_screen.dart';
import '../../features/organizations/screens/organizations_list_screen.dart';
import '../../helpers/typedefs.dart';

@immutable
class Routes {
  const Routes._();

  static const String initialRoute = AppStartupScreenRoute;
  static const String fallbackRoute = NotFoundScreenRoute;

  static const String AppStartupScreenRoute = '/app-startup-screen';
  static const String LoginScreenRoute = '/login-screen';
  static const String RegisterVolunteerScreenRoute =
      '/register-volunteer-screen';
  static const String RegisterOrgScreenRoute = '/register-org-screen';
  static const String ForgotPasswordScreenRoute = '/forgot-password-screen';
  static const String HomeScreenRoute = '/home-screen';
  static const String NotFoundScreenRoute = '/route-not-found-screen';
  static const String EventsListScreenRoute = '/events-list-screen';
  static const String EventDetailsScreenRoute = '/event-details-screen';
  static const String EditEventScreenRoute = '/edit-event-screen';
  static const String OrganizationsListScreenRoute = '/orgs-list-screen';
  static const String OrganizationDetailsScreenRoute = '/org-details-screen';
  static const String EditOrganizationScreenRoute = '/edit-org-screen';
  static const String ProfileScreenRoute = '/profile-screen';
  static const String EditProfileScreenRoute = '/edit-profile-screen';
  static const String EventHistoryScreenRoute = '/event-history-screen';

  static final Map<String, RouteBuilder> _routesMap = {
    AppStartupScreenRoute: (_) => const AppStartupScreen(),
    LoginScreenRoute: (_) => const LoginScreen(),
    RegisterVolunteerScreenRoute: (_) => const RegisterVolunteerScreen(),
    RegisterOrgScreenRoute: (_) => const RegisterOrganizationScreen(),
    ForgotPasswordScreenRoute: (_) => const ForgotPassword(),
    HomeScreenRoute: (_) => const HomeScreen(),
    EventsListScreenRoute: (_) => const EventsListScreen(),
    EventDetailsScreenRoute: (_) => const EventDetailsScreen(),
    EditEventScreenRoute: (_) => const EditEventScreen(),
    OrganizationsListScreenRoute: (_) => const OrganizationsListScreen(),
    OrganizationDetailsScreenRoute: (_) => const OrganizationDetailsScreen(),
    EditOrganizationScreenRoute: (_) => const EditOrganizationScreen(),
    ProfileScreenRoute: (_) => const ProfileScreen(),
    NotFoundScreenRoute: (_) => const SizedBox.shrink(),
    // Edit profile screen
    // Event history screen
  };

  static RouteBuilder getRoute(String? routeName) {
    return routeExists(routeName)
        ? _routesMap[routeName]!
        : _routesMap[Routes.NotFoundScreenRoute]!;
  }

  static bool routeExists(String? routeName) {
    return _routesMap.containsKey(routeName);
  }
}
