import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/Models/user_model.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserEntity> signUpWithEmailPass({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> logInWithEmailPass({
    required String email,
    required String password,
  });

  // Getting the current userdata to persist the LoggedIn session
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});

// Getting the current session if there is one
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

// Login with email pass
  @override
  Future<UserEntity> logInWithEmailPass(
      {required String email, required String password}) async {
    try {
      final responce = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (responce.user == null) {
        throw ServerExceptions(message: "The User is null!");
      }
      return UserModel.fromJson(responce.user!.toJson());
    } catch (e) {
      throw ServerExceptions(message: e.toString());
    }
  }

// SignUp with emailpass
  @override
  Future<UserEntity> signUpWithEmailPass(
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
      return UserModel.fromJson(responce.user!.toJson());
    } catch (e) {
      throw ServerExceptions(message: e.toString());
    }
  }

// Getting Current user data
  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );

        return UserModel.fromJson(userData.first);
      }
      return null;
    } catch (e) {
      throw ServerExceptions(message: e.toString());
    }
  }
}
