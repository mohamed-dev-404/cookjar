import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:cookjar/core/services/network/api_consumer.dart';
import 'package:cookjar/core/services/network/dio_consumer.dart';

/// This file is responsible for registering all the services
/// that will be used in the app using GetIt package for [dependency_injection].
final GetIt getIt = GetIt.instance;

//* This function will be called in the main function before running the app
void setupServiceLocator() {
  //! shared network services
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(getIt<Dio>()));

  //! Auth Feature

  //? Repo
  // getIt.registerLazySingleton<AuthRepo>(
  //   () => AuthRepoImpl(getIt<ApiConsumer>()),
  // );

  // //? Cubits
  // getIt.registerFactory<LoginCubit>(
  //   () => LoginCubit(authRepo: getIt<AuthRepo>()),
  // );
  // getIt.registerFactory<RegisterCubit>(
  //   () => RegisterCubit(authRepo: getIt<AuthRepo>()),
  // );
  // getIt.registerFactory<LogoutCubit>(() => LogoutCubit(getIt<AuthRepo>()));

  //! Complete Profile Feature

  // //? Repo
  // getIt.registerLazySingleton<CompleteProfileRepo>(
  //   () => CompleteProfileRepoImpl(getIt<ApiConsumer>()),
  // );

  // //? Cubit
  // getIt.registerFactory<CompleteProfileCubit>(
  //   () =>
  //       CompleteProfileCubit(completeProfileRepo: getIt<CompleteProfileRepo>()),
  // );


}
