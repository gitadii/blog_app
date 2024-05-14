part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final String posterId;
  final File imageUrl;
  final String title;
  final String content;
  final List<String> topics;

  BlogUploadEvent({
    required this.posterId,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.topics,
  });
}

final class BlogFetchAllBlogEvent extends BlogEvent {}

// Logout
final class BlogAuthLogOut extends BlogEvent {}
