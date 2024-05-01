// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/bloc/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<String> uploadBlogImg({
    required File image,
    required BlogModel blogModel,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl({
    required this.supabaseClient,
  });

// Method will upload a blog to supabase after converting it to Json format
  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blogModel.toJson())
          .select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerExceptions(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImg({
    required File image,
    required BlogModel blogModel,
  }) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload(blogModel.id, image);

      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blogModel.id);
    } catch (e) {
      throw ServerExceptions(message: e.toString());
    }
  }
}
