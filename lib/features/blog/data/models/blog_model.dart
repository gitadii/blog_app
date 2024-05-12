import 'package:blog_app/core/constants/supabase/supabase_table_fields.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.id,
    required super.imageUrl,
    required super.posterId,
    required super.title,
    required super.content,
    required super.topics,
    required super.updatedAt,
    super.posterName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      TableFields.id: id,
      TableFields.imageUrl: imageUrl,
      TableFields.posterId: posterId,
      TableFields.title: title,
      TableFields.content: content,
      TableFields.topics: topics,
      TableFields.updatedAt: updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map[TableFields.id] as String,
      imageUrl: map[TableFields.imageUrl] as String,
      posterId: map[TableFields.posterId] as String,
      title: map[TableFields.title] as String,
      content: map[TableFields.content] as String,
      topics: List<String>.from(map[TableFields.title] ?? []),
      updatedAt: map[TableFields.updatedAt] == null
          ? DateTime.now()
          : DateTime.parse(map[TableFields.updatedAt]),
    );
  }

  BlogModel copyWith({
    String? id,
    String? imageUrl,
    String? posterId,
    String? title,
    String? content,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
