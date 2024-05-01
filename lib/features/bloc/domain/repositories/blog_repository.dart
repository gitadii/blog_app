import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/bloc/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File imageUrl,
    required String blogTitle,
    required String blogContent,
    required String posterId,
    required List<String> blogCategories,
  });
}
