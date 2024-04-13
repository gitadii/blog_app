import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  // SignUp
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  // LogIn
  Future<Either<Failure, UserEntity>> logInWithEmail({
    required String email,
    required String password,
  });
}
