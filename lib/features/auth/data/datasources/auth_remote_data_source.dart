import 'package:blog_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPass({
    required String name,
    required String email,
    required String password,
  });
  Future<String> logInWithEmailPass({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<String> logInWithEmailPass(
      {required String email, required String password}) {
    // TODO: implement logInWithEmailPass
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPass(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final responce = await supabaseClient.auth
          .signUp(password: password, email: email, data: {
        'name': name,
      });
      if (responce.user == null) {
        throw ServerExceptions(message: "The User is null!");
      }
      return responce.user!.id;
    } catch (e) {
      throw ServerExceptions(message: e.toString());
    }
  }
}
