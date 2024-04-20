import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/credentials/supabase_creds.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: SupaBaseCreds.supabaseUrl,
    anonKey: SupaBaseCreds.supabaseAnonKey,
  );

  // Dependency of supabase.client
  serviceLocator.registerLazySingleton(() => supabase.client);

  // Core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // Dependency of RemoteDataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )

    // Dep of AuthRepo
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )

    // Dep of UserSignUp
    ..registerFactory(
      () => UserSignUp(
        authRepository: serviceLocator(),
      ),
    )

    // Dep of UserLogIn
    ..registerFactory(
      () => UserLogIn(
        authRepository: serviceLocator(),
      ),
    )

    // Dep of CurrentUser
    ..registerFactory(
      () => CurrentUser(
        authRepository: serviceLocator(),
      ),
    );

  // Dep of AuthBloc
  // It is LazySingleton because we dont want multiple states in our app, e.g. it the app is in Loading state and another
  // instance of AuthBloc is created then it will again go in Initialization state.
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogIn: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}
