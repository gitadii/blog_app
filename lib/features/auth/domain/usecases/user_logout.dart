import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/usecase_interf.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogout implements UseCase<Future<void>, NoParams> {
  AuthRepository authRepository;
  UserLogout({required this.authRepository});

  @override
  Future<Either<Failure, Future<void>>> call(params) async {
    return await authRepository.logOutUser();
  }
}
