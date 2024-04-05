import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  // SignUp
  Future<Either<Failure, String>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  // LogIn
  Future<Either<Failure, String>> logInWithEmail({
    required String email,
    required String password,
  });
}
