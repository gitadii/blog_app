import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/usecase_interf.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogout implements UseCase<Future<void>, NoParams> {
  BlogRepository blogRepository;
  UserLogout({required this.blogRepository});

  @override
  Future<Either<Failure, Future<void>>> call(params) async {
    return await blogRepository.logOutUser();
  }
}
