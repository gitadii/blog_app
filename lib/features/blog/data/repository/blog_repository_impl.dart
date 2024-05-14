import 'dart:io';

import 'package:blog_app/core/constants/constants.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  BlogRemoteDataSource blogRemoteDataSource;
  BlogLocalDataSource blogLocalDataSource;
  ConnectionChecker connectionChecker;
  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.blogLocalDataSource,
    required this.connectionChecker,
  });

//TODO: local storage not working!
// Uploading blog
  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File imageUrl,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionMessage));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(), // Generating a random uuid
        imageUrl: '',
        posterId: posterId,
        title: title,
        content: content,
        topics: topics,
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

// Retrieving all blogs
  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }

      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadBlogs(blogs);

      return right(blogs);
    } on ServerExceptions catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Logout
  @override
  Future<Either<Failure, Future<void>>> logOutUser() async {
    try {
      return right(blogRemoteDataSource.logOutUser());
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
