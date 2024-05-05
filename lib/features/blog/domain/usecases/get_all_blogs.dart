import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/usecase_interf.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUseCase implements UseCase<List<BlogEntity>, NoParams> {
  BlogRepository blogRepository;
  GetAllBlogsUseCase({required this.blogRepository});

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams noParams) async {
    return await blogRepository.getAllBlogs();
  }
}
