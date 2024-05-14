import 'dart:io';

import 'package:blog_app/core/constants/supabase/supabase_constants.dart';
import 'package:blog_app/core/constants/supabase/supabase_quries.dart';
import 'package:blog_app/core/constants/supabase/supabase_table_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  // Uploading blog
  Future<BlogModel> uploadBlog(BlogModel blogModel);

// Uploading image
  Future<String> uploadBlogImg({
    required File image,
    required BlogModel blogModel,
  });

  // Retrieving blogs
  Future<List<BlogModel>> getAllBlogs();

  // Logout
  Future<void> logOutUser();
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

// Uploading blog Image to storage bucket
  @override
  Future<String> uploadBlogImg({
    required File image,
    required BlogModel blogModel,
  }) async {
    try {
      await supabaseClient.storage
          .from(SupaBaseConstants.blogImageBucketId)
          .upload(blogModel.id, image);

      return supabaseClient.storage
          .from(SupaBaseConstants.blogImageBucketId)
          .getPublicUrl(blogModel.id);
    } catch (e) {
      throw ServerExceptions(message: e.toString());
    }
  }

// Retrieving all the blogs
  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient
          .from(SupaBaseConstants.blogsTable)
          .select(SupaBaseQuries.getAllBlogs);
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              posterName: blog[SupaBaseConstants.profileTable]
                  [TableFields.name],
            ),
          )
          .toList();
    } catch (e) {
      throw ServerExceptions(message: e.toString());
    }
  }

  // Logout
  @override
  Future<void> logOutUser() async {
    try {
      return await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerExceptions(message: e.toString());
    }
  }
}
