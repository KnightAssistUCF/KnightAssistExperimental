import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/config/config.dart';
import 'package:knightassist/src/core/core.dart';
import 'package:knightassist/src/features/images/providers/images_provider.dart';
import 'package:knightassist/src/features/qr/providers/qr_provider.codegen.dart';
import 'package:knightassist/src/features/qr/repositories/qr_repository.codegen.dart';
import 'package:knightassist/src/global/states/auth_state.codegen.dart';

import '../../core/networking/interceptors/refresh_token_interceptor.dart';
import '../../features/announcements/providers/announcements_provider.dart';
import '../../features/announcements/repositories/announcements_repository.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/forgot_password_provider.dart';
import '../../features/auth/repositories/auth_repository.dart';
import '../../features/events/providers/events_provider.dart';
import '../../features/events/providers/feedback_provider.dart';
import '../../features/events/repositories/events_repository.dart';
import '../../features/events/repositories/feedback_repository.dart';
import '../../features/images/repositories/images_repository.dart';
import '../../features/organizations/providers/organizations_provider.dart';
import '../../features/organizations/repositories/organizations_repository.dart';
import '../../features/volunteers/providers/volunteers_provider.dart';
import '../../features/volunteers/repositories/volunteers_repository.dart';
import '../states/forgot_password_state.codegen.dart';

// services
final keyValueStorageServiceProvider = Provider<KeyValueStorageService>(
  (ref) => KeyValueStorageService(),
);

final _dioProvider = Provider<Dio>((ref) {
  final baseOptions = BaseOptions(
    baseUrl: Config.baseUrl,
  );
  return Dio(baseOptions);
});

final _dioServiceProvider = Provider<DioService>((ref) {
  final dio = ref.watch(_dioProvider);
  return DioService(
    dioClient: dio,
    interceptors: [
      ApiInterceptor(ref),
      if (kDebugMode) LoggingInterceptor(),
      RefreshTokenInterceptor(dioClient: dio, ref: ref)
    ],
  );
});

final _apiServiceProvider = Provider<ApiService>((ref) {
  final dioService = ref.watch(_dioServiceProvider);
  return ApiService(dioService);
});

// repositories providers
final _announcementsRepositoryProvider =
    Provider<AnnouncementsRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return AnnouncementsRepository(apiService: apiService);
});

final _authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return AuthRepository(apiService: apiService);
});

final _eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return EventsRepository(apiService: apiService);
});

final _feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return FeedbackRepository(apiService: apiService);
});

final _imagesRepositoryProvider = Provider<ImagesRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return ImagesRepository(apiService: apiService);
});

final _organizationsRepositoryProvider =
    Provider<OrganizationsRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return OrganizationsRepository(apiService: apiService);
});

final _qrRepositoryProvider = Provider<QrRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return QrRepository(apiService: apiService);
});

final _volunteersRepositoryProvider = Provider<VolunteersRepository>((ref) {
  final apiService = ref.watch(_apiServiceProvider);
  return VolunteersRepository(apiService: apiService);
});

// notifier providers
final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final authRepository = ref.watch(_authRepositoryProvider);
  final keyValueStorageService = ref.watch(keyValueStorageServiceProvider);
  return AuthProvider(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

final forgotPasswordProvider = StateNotifierProvider.autoDispose<
    ForgotPasswordProvider, ForgotPasswordState>((ref) {
  final authRepository = ref.watch(_authRepositoryProvider);
  return ForgotPasswordProvider(
    authRepository: authRepository,
    initialState: const ForgotPasswordState.email(),
  );
});

// data providers
final announcementsProvider = Provider<AnnouncementsProvider>((ref) {
  final announcementsRepository = ref.watch(_announcementsRepositoryProvider);
  return AnnouncementsProvider(announcementsRepository);
});

final eventsProvider = Provider<EventsProvider>((ref) {
  final eventsRepository = ref.watch(_eventsRepositoryProvider);
  return EventsProvider(eventsRepository: eventsRepository, ref: ref);
});

final feedbackProvider = Provider<FeedbackProvider>((ref) {
  final feedbackRepository = ref.watch(_feedbackRepositoryProvider);
  return FeedbackProvider(feedbackRepository);
});

final imagesProvider = Provider<ImagesProvider>((ref) {
  final imagesRepository = ref.watch(_imagesRepositoryProvider);
  return ImagesProvider(imagesRepository);
});

final organizationsProvider = Provider<OrganizationsProvider>((ref) {
  final organizationsRepository = ref.watch(_organizationsRepositoryProvider);
  return OrganizationsProvider(organizationsRepository);
});

final qrProvider = Provider<QrProvider>((ref) {
  final qrRepository = ref.watch(_qrRepositoryProvider);
  return QrProvider(qrRepository: qrRepository, ref: ref);
});

final volunteersProvider = Provider<VolunteersProvider>((ref) {
  final volunteersRepository = ref.watch(_volunteersRepositoryProvider);
  return VolunteersProvider(volunteersRepository);
});
