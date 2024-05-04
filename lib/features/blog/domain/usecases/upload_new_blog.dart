import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/usecase_interf.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase
    implements UseCase<BlogEntity, UploadBlogUsecaseParams> {
  BlogRepository blogRepository;
  UploadBlogUsecase({required this.blogRepository});

  @override
  Future<Either<Failure, BlogEntity>> call(
      UploadBlogUsecaseParams params) async {
    return await blogRepository.uploadBlog(
      imageUrl: params.imageUrl,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogUsecaseParams {
  final String posterId;
  final File imageUrl;
  final String title;
  final String content;
  final List<String> topics;

  UploadBlogUsecaseParams({
    required this.posterId,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.topics,
  });
}
