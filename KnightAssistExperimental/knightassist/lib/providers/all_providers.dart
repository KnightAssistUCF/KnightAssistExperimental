import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist/providers/auth_provider.dart';
import 'package:knightassist/providers/states/auth_state.dart';
import 'package:knightassist/providers/states/forgot_password_state.dart';
import 'package:knightassist/services/networking/interceptors/api_interceptor.dart';
import 'package:knightassist/services/networking/interceptors/logging_interceptor.dart';
import 'package:knightassist/services/networking/interceptors/refresh_token_interceptor.dart';
import 'package:knightassist/services/repositories/auth_repository.dart';

import '../services/local_storage/key_value_storage_service.dart';
import '../services/networking/api_endpoint.dart';
import '../services/networking/api_service.dart';
import '../services/networking/dio_service.dart';
import 'forgot_password_provider.dart';

final keyValueStorageServiceProvider = Provider<KeyValueStorageService>(
  (ref) => KeyValueStorageService(),
);

final _dioProvider = Provider<Dio>((ref) {
  final baseOptions = BaseOptions(
    baseUrl: ApiEndpoint.baseUrl,
  );
  return Dio(baseOptions);
});

final _dioServiceProvider = Provider<DioService>((ref) {
  final _dio = ref.watch(_dioProvider);
  return DioService(
    dioClient: _dio,
    interceptors: [
      ApiInterceptor(ref),
      if (kDebugMode) LoggingInterceptor(),
      RefreshTokenInterceptor(dioClient: _dio, ref: ref)
    ],
  );
});

final _apiServiceProvider = Provider<ApiService>((ref) {
  final _dioService = ref.watch(_dioServiceProvider);
  return ApiService(_dioService);
});

// repositories providers
final _authRepositoryProvider = Provider<AuthRepository>((ref) {
  final _apiService = ref.watch(_apiServiceProvider);
  return AuthRepository(apiService: _apiService);
});

final _eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  final _apiService = ref.watch(_apiServiceProvider);
  return EventsRepository(apiService: _apiService);
});

// notifier providers
final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  final _keyValueStorageService = ref.watch(keyValueStorageServiceProvider);
  return AuthProvider(
    ref: ref,
    authRepository: _authRepository,
    keyValueStorageService: _keyValueStorageService,
  );
});

final forgotPasswordProvider = StateNotifierProvider.autoDispose<
    ForgotPasswordProvider, ForgotPasswordState>((ref) {
  final _authRepository = ref.watch(_authRepositoryProvider);
  return ForgotPasswordProvider(
    authRepository: _authRepository,
    initialState: const ForgotPasswordState.email(),
  );
});

// data providers

final eventsProvider = Provider<EventsProvider>((ref) {
  final _eventsRepository = ref.watch(_eventsRepositoryProvider);
  return EventsProvider(_eventsRepository);
});
