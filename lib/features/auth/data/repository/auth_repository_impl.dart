import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/Models/user_model.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl({
    required this.connectionChecker,
    required this.remoteDataSource,
  });

  // Login
  @override
  Future<Either<Failure, UserEntity>> logInWithEmail(
      {required String email, required String password}) {
    return _getUser(
      () async => await remoteDataSource.logInWithEmailPass(
        email: email,
        password: password,
      ),
    );
  }

  // SignUp
  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPass(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final curUserSession = remoteDataSource.currentUserSession;

        if (curUserSession == null) {
          return left(Failure("The user is not logged in!"));
        }

        return right(
          UserModel(
            id: curUserSession.user.id,
            email: curUserSession.user.email ?? '',
            name: '',
          ),
        );
      }

      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("The user is not logged in!"));
      }
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  // Getting user, r => returning userEntity, l => error message
  Future<Either<Failure, UserEntity>> _getUser(
      Future<UserEntity> Function() fn) async {
    try {
      if (!await connectionChecker.isConnected) {
        left(Failure('No Internet Connection'));
      }

      final userEntity = await fn();
      return right(userEntity);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
