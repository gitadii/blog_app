class BlogEntity {
  final String id;
  final String imageUrl;
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;
  final DateTime updatedAt;
  final String? posterName;

  BlogEntity({
    required this.id,
    required this.imageUrl,
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
    required this.updatedAt,
    this.posterName,
  });
}
