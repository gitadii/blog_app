import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/bloc/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/bloc/data/models/blog_model.dart';
import 'package:blog_app/features/bloc/domain/entities/blog_entity.dart';
import 'package:blog_app/features/bloc/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File imageUrl,
    required String blogTitle,
    required String blogContent,
    required String posterId,
    required List<String> blogCategories,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(), // Generating a random uuid
        imageUrl: '',
        posterId: posterId,
        blogTitle: blogTitle,
        blogContent: blogContent,
        blogCatrgories: blogCategories,
        updatedAt: DateTime.now(),
      );

      final image = await blogRemoteDataSource.uploadBlogImg(
        image: imageUrl,
        blogModel: blogModel,
      );

      blogModel = blogModel.copyWith(
        imageUrl: image,
      );

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
