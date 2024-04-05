import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, String>> logInWithEmail(
      {required String email, required String password}) {
    // TODO: implement logInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailPass(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}