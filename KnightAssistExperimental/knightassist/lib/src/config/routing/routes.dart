// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:knightassist/src/features/announcements/screens/add_announcement_screen.dart';
import 'package:knightassist/src/features/announcements/screens/announcements_list_screen.dart';
import 'package:knightassist/src/features/auth/screens/edit_profile_screen.dart';
import 'package:knightassist/src/features/events/screens/add_event_screen.dart';
import 'package:knightassist/src/features/events/screens/feedback_list_screen.dart';
import 'package:knightassist/src/features/events/screens/leave_feedback_screen.dart';
import 'package:knightassist/src/features/qr/screens/qr_confirmation_screen.dart';
import 'package:knightassist/src/features/qr/screens/qr_screen.dart';

import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/profile_screen.dart';
import '../../features/auth/screens/register_organization_screen.dart';
import '../../features/auth/screens/register_volunteer_screen.dart';
import '../../features/events/screens/edit_event_screen.dart';
import '../../features/events/screens/event_details_screen.dart';
import '../../features/events/screens/event_history_list_screen.dart';
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
  static const String AddEventScreenRoute = '/add-event-screen';
  static const String EditEventScreenRoute = '/edit-event-screen';
  static const String OrganizationsListScreenRoute = '/orgs-list-screen';
  static const String OrganizationDetailsScreenRoute = '/org-details-screen';
  static const String EditOrganizationScreenRoute = '/edit-org-screen';
  static const String ProfileScreenRoute = '/profile-screen';
  static const String EditProfileScreenRoute = '/edit-profile-screen';
  static const String EventHistoryListScreenRoute = '/event-history-screen';
  static const String QrScreenRoute = '/qr-screen';
  static const String FeedbackListScreenRoute = '/feedback-list-screen';
  static const String LeaveFeedbackScreenRoute = '/leave-feedback-screen';
  static const String AnnouncementsListScreenRoute =
      '/announcements-list-screen';
  static const String AddAnnouncementScreenRoute = '/add-announcement-screen';
  static const String QrConfirmationScreenRoute = '/qr-confirmation-screen';

  static final Map<String, RouteBuilder> _routesMap = {
    AppStartupScreenRoute: (_) => const AppStartupScreen(),
    LoginScreenRoute: (_) => const LoginScreen(),
    RegisterVolunteerScreenRoute: (_) => const RegisterVolunteerScreen(),
    RegisterOrgScreenRoute: (_) => const RegisterOrganizationScreen(),
    ForgotPasswordScreenRoute: (_) => const ForgotPassword(),
    HomeScreenRoute: (_) => HomeScreen(),
    EventsListScreenRoute: (_) => EventsListScreen(),
    EventDetailsScreenRoute: (_) => const EventDetailsScreen(),
    AddEventScreenRoute: (_) => const AddEventScreen(),
    EditEventScreenRoute: (_) => const EditEventScreen(),
    OrganizationsListScreenRoute: (_) => OrganizationsListScreen(),
    OrganizationDetailsScreenRoute: (_) => const OrganizationDetailsScreen(),
    EditOrganizationScreenRoute: (_) => const EditOrganizationScreen(),
    ProfileScreenRoute: (_) => const ProfileScreen(),
    EditProfileScreenRoute: (_) => const EditProfileScreen(),
    QrScreenRoute: (_) => const QrScreen(),
    LeaveFeedbackScreenRoute: (_) => const LeaveFeedbackScreen(),
    AnnouncementsListScreenRoute: (_) => AnnouncementsListScreen(),
    EventHistoryListScreenRoute: (_) => EventHistoryListScreen(),
    FeedbackListScreenRoute: (_) => FeedbackListScreen(),
    AddAnnouncementScreenRoute: (_) => const AddAnnouncementScreen(),
    QrConfirmationScreenRoute: (_) =>
        const QrConfirmationScreen(checkIn: false, eventId: ''),
  };

  static RouteBuilder getRoute(String? routeName) {
    return _routesMap[routeName]!;
  }

  static bool routeExists(String? routeName) {
    return _routesMap.containsKey(routeName);
  }
}
