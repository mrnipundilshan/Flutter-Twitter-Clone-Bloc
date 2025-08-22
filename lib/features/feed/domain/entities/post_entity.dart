class PostEntity {
  final String? id;
  final String userId;
  final String username;
  final String content;
  final DateTime createdAt;
  final int? likesCount;
  final int? commentsCount;
  final int? repostsCount;
  final String? imageUrl;
  final bool? isLikedBycurrentUser;

  PostEntity({
    this.id,
    required this.userId,
    required this.username,
    required this.content,
    required this.createdAt,
    this.likesCount,
    this.commentsCount,
    this.repostsCount,
    this.imageUrl,
    this.isLikedBycurrentUser,
  }) {
    if (username.trim().isEmpty) {
      throw Exception("Username cannot be empty");
    }
    if (content.trim().isEmpty) {
      throw Exception("Post Content cannot be empty");
    }
  }

  //serialisation layer //
  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'],
      userId: json['user_id'],
      username: json['username'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      imageUrl: json['image_url'],
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      repostsCount: json['reposts_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'username': username,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'image_url': imageUrl,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'reposts_count': repostsCount,
    };
  }

  PostEntity copyWith({
    String? id,
    String? userId,
    String? username,
    String? content,
    DateTime? createdAt,
    int? likesCount,
    int? commentsCount,
    int? repostsCount,
    String? imageUrl,
    bool? isLikedBycurrentUser,
  }) {
    return PostEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      repostsCount: repostsCount ?? this.repostsCount,
      imageUrl: imageUrl ?? this.imageUrl,
      isLikedBycurrentUser: isLikedBycurrentUser ?? this.isLikedBycurrentUser,
    );
  }

  bool hasImage() => imageUrl != null && imageUrl!.isNotEmpty;
}
