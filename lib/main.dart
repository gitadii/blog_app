import 'package:blog_app/core/credentials/supabase_creds.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'routes.dart';

// Supabase : it_blog_app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = await Supabase.initialize(
    url: SupaBaseCreds.supabaseUrl,
    anonKey: SupaBaseCreds.supabaseAnonKey,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            authRepository: AuthRepositoryImpl(
              remoteDataSource:
                  AuthRemoteDataSourceImpl(supabaseClient: supabase.client),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Blog it',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => loggedOutRoute,
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
