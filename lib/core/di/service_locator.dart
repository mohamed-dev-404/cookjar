import 'package:cookjar/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:cookjar/features/auth/data/repos/auth_repo.dart';
import 'package:cookjar/features/auth/data/repos/auth_repo_impl.dart';
import 'package:cookjar/features/auth/presentation/login/view_model/login_cubit.dart';
import 'package:cookjar/features/auth/presentation/register/view_model/register_cubit.dart';
import 'package:cookjar/features/profile/data/data_source/profile_local_data_source.dart';
import 'package:cookjar/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:cookjar/features/profile/data/repos/profile_repo.dart';
import 'package:cookjar/features/profile/data/repos/profile_repo_impl.dart';
import 'package:cookjar/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:cookjar/features/recipe_details/data/data_source/recipe_details_remote_data_source.dart';
import 'package:cookjar/features/recipe_details/data/repos/recipe_details_repo.dart';
import 'package:cookjar/features/recipe_details/data/repos/recipe_details_repo_impl.dart';
import 'package:cookjar/features/recipe_details/presentation/view_model/recipe_details_cubit.dart';
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
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  //? Repo
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );

  //? Cubits
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(authRepo: getIt<AuthRepo>()),
  );

  //! Profile Feature
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(
      remoteDataSource: getIt<ProfileRemoteDataSource>(),
      localDataSource: getIt<ProfileLocalDataSource>(),
    ),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(profileRepo: getIt<ProfileRepo>()),
  );

  //! Recipe Details Feature
  getIt.registerLazySingleton<RecipeDetailsRemoteDataSource>(
    () => RecipeDetailsRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );

  //? Repo
  getIt.registerLazySingleton<RecipeDetailsRepo>(
    () => RecipeDetailsRepoImpl(
      remoteDataSource: getIt<RecipeDetailsRemoteDataSource>(),
    ),
  );

  //? Cubit
  getIt.registerFactory<RecipeDetailsCubit>(
    () => RecipeDetailsCubit(recipeDetailsRepo: getIt<RecipeDetailsRepo>()),
  );
}
