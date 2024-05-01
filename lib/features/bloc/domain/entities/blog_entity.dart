class BlogEntity {
  final String id;
  final String imageUrl;
  final String posterId;
  final String blogTitle;
  final String blogContent;
  final List<String> blogCatrgories;
  final DateTime updatedAt;

  BlogEntity({
    required this.id,
    required this.imageUrl,
    required this.posterId,
    required this.blogTitle,
    required this.blogContent,
    required this.blogCatrgories,
    required this.updatedAt,
  });
}
