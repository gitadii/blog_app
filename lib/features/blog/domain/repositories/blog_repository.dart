import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  // Uploading blog
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File imageUrl,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

// Retrieving blogs
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs();

  // Logout
  Future<Either<Failure, Future<void>>> logOutUser();
}
