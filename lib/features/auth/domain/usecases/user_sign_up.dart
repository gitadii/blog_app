import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/usecase_interf.dart';
import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<UserEntity, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmail(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
