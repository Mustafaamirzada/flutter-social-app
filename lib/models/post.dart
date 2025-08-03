// import 'dart:convert';
// Post postFromJson(String str) => Post.fromJson(json.decode(str));
// List<Post> postListFromJson(String str) =>
//   List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

// String postToJson(Post data) => json.encode(data.toJson());

// class Posts {
//   List<Post> data;

//   Posts({
//     required this.data,
//   });

//   factory Posts.fromJson(Map<String, dynamic> json) => Posts(
//         data: List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// ignore_for_file: unused_local_variable

class Post {
  final int id;
  final String title;
  final String description;
  final int userId;
  final String mediaUrl;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.mediaUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return Post(
      id: json['id'],
      title: attr["title"] ?? '',
      description: attr["description"] ?? '',
      userId: attr["user_id"],
      mediaUrl: attr["media_url"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id" : id,
        "title": title,
        "description": description,
        "user_id": userId,
        "media_url": mediaUrl,
      };
}
