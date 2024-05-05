import 'dart:io';

import 'package:blog_app/core/usecases/usecase_interf.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_new_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;

  BlogBloc(
      {required UploadBlogUsecase uploadBlogUsecase,
      required GetAllBlogsUseCase getAllBlogsUseCase})
      : _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogsUseCase = getAllBlogsUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUploadEvent);
    on<BlogFetchAllBlogEvent>(_onGetAllBlogEvent);
  }

  void _onBlogUploadEvent(
      BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlogUsecase.call(
      UploadBlogUsecaseParams(
        posterId: event.posterId,
        imageUrl: event.imageUrl,
        title: event.title,
        content: event.content,
        topics: event.topics,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(error: l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onGetAllBlogEvent(
      BlogFetchAllBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogsUseCase.call(NoParams());

    res.fold(
      (l) => emit(BlogFailure(error: l.message)),
      (r) => emit(BlogDisplaySuccess(blogs: r)),
    );
  }
}
