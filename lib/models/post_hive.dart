import 'package:flutter_social_app/models/post.dart';
import 'package:hive/hive.dart';

part 'post_hive.g.dart';

@HiveType(typeId: 2)
class PostHiveModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  int userId;

  @HiveField(4)
  String mediaUrl;
  
  @HiveField(5)
  int likeCount;

  @HiveField(6)
  int commentCount;

  PostHiveModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.mediaUrl,
    required this.likeCount,
    required this.commentCount,
  });


  static PostHiveModel fromApi(Post post) {
    return PostHiveModel(
      id: post.id,
      title: post.title,
      description: post.description,
      userId: post.userId,
      mediaUrl: post.mediaUrl,
      likeCount: post.likeCount,
      commentCount: post.commentCount,
    );
  }

  static Post toApi(PostHiveModel hiveModel) {
    return Post(
      id: hiveModel.id,
      title: hiveModel.title,
      description: hiveModel.description,
      userId: hiveModel.userId,
      mediaUrl: hiveModel.mediaUrl,
      likeCount: hiveModel.likeCount,
      commentCount: hiveModel.commentCount,
      
    );
  }
}
