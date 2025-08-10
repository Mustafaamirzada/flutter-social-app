class Post {
  final int id;
  final String title;
  final String description;
  final int userId;
  final String mediaUrl;
  final int likeCount;
  final int commentCount;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.mediaUrl,
    required this.likeCount,
    required this.commentCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return Post(
      id: json['id'],
      title: attr["title"] ?? '',
      description: attr["description"] ?? '',
      userId: attr["user_id"],
      mediaUrl: attr["media_url"] ?? '',
      likeCount: json['like_count'] ?? 0,
      commentCount: json['comment_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id" : id,
        "title": title,
        "description": description,
        "user_id": userId,
        "media_url": mediaUrl,
        "like_count": likeCount,
        "comment_count": commentCount,
      };
}
