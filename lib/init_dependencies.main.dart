part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
    url: SupaBaseCreds.supabaseUrl,
    anonKey: SupaBaseCreds.supabaseAnonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  // Dependency of supabase.client
  serviceLocator.registerLazySingleton(() => supabase.client);

  // Internet Connection
  serviceLocator.registerFactory(
    () => InternetConnection(),
  );

  // Hive Box
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: Constants.blogsBox),
  );

  // Core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(internetConnection: serviceLocator()));
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
        connectionChecker: serviceLocator(),
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
    )

    // Dep of UserLogout
    ..registerFactory(
      () => UserLogout(
        blogRepository: serviceLocator(),
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

void _initBlog() {
  //DataSource
  serviceLocator
    ..registerLazySingleton<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerLazySingleton<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        box: serviceLocator(),
      ),
    )

    //Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )

    //Usecases
    ..registerFactory(
      () => UploadBlogUsecase(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogsUseCase(
        blogRepository: serviceLocator(),
      ),
    )

    //Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlogUsecase: serviceLocator(),
        getAllBlogsUseCase: serviceLocator(),
        userLogout: serviceLocator(),
      ),
    );
}
