import 'package:blog_app/features/bloc/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.id,
    required super.imageUrl,
    required super.posterId,
    required super.blogTitle,
    required super.blogContent,
    required super.blogCatrgories,
    required super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'image_url': imageUrl,
      'poster_id': posterId,
      'blog_title': blogTitle,
      'blog_content': blogContent,
      'blog_catrgories': blogCatrgories,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      imageUrl: map['image_url'] as String,
      posterId: map['poster_id'] as String,
      blogTitle: map['blog_title'] as String,
      blogContent: map['blog_content'] as String,
      blogCatrgories: List<String>.from(map['blog_catrgories'] ?? []),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

  BlogModel copyWith({
    String? id,
    String? imageUrl,
    String? posterId,
    String? blogTitle,
    String? blogContent,
    List<String>? blogCatrgories,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      posterId: posterId ?? this.posterId,
      blogTitle: blogTitle ?? this.blogTitle,
      blogContent: blogContent ?? this.blogContent,
      blogCatrgories: blogCatrgories ?? this.blogCatrgories,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
