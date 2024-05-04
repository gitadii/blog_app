import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_new_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase uploadBlogUsecase;

  BlogBloc(
    this.uploadBlogUsecase,
  ) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUploadEvent);
  }

  void _onBlogUploadEvent(
      BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await uploadBlogUsecase.call(
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
      (r) => emit(BlogSuccess()),
    );
  }
}
