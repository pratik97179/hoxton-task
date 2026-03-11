import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:hoxton_task/core/network/api_client.dart';
import 'package:hoxton_task/core/network/api_logger_interceptor.dart';
import 'package:hoxton_task/core/session/session_manager.dart';
import 'package:hoxton_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hoxton_task/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hoxton_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:hoxton_task/features/auth/domain/usecases/login_with_email_password.dart';
import 'package:hoxton_task/features/auth/domain/usecases/register_with_email_password.dart';
import 'package:hoxton_task/features/home/data/datasources/home_remote_data_source.dart';
import 'package:hoxton_task/features/home/presentation/controllers/home_controller.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Core
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3000',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: <String, Object>{'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(ApiLoggerInterceptor());
    return dio;
  });

  sl.registerLazySingleton<ApiClient>(() => ApiClient(dio: sl<Dio>()));

  sl.registerLazySingleton<SessionManager>(() => SessionManager());

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton<RegisterWithEmailPassword>(
    () => RegisterWithEmailPassword(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LoginWithEmailPassword>(
    () => LoginWithEmailPassword(sl<AuthRepository>()),
  );

  // Home
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl<ApiClient>()),
  );

  sl.registerLazySingleton<HomeController>(
    () => HomeController(
      sl<HomeRemoteDataSource>(),
      sl<SessionManager>(),
    ),
  );
}
