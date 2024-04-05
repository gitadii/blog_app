import 'package:blog_app/core/credentials/supabase_creds.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'routes.dart';

// Supabase : it_blog_app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupaBaseCreds.supabaseUrl,
    anonKey: SupaBaseCreds.supabaseAnonKey,
  );

  runApp(const MyApp());
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
