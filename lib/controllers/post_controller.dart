import 'package:fchat/models/post.dart';
import 'package:fchat/repository/post_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PostController {
  final PostRepository _postsRepository = PostRepository();
  InternetConnectionChecker intchecker = InternetConnectionChecker.instance;

  Future<List<Post>> getPosts() async {
    try {
      final hasConnected = await intchecker.hasConnection;
      if (hasConnected) {
        final serverResponse = await _postsRepository.getAllPosts();
        await _postsRepository.cachePostLocally(posts: serverResponse);
        final localPosts = await _postsRepository.getLocalPosts();
        return localPosts;
      } else {
        final localPosts = await _postsRepository.getLocalPosts();
        return localPosts;
      }
    } catch (e) {
      print('Error Getting Posts: $e');
      throw Exception(Exception('Failed to load posts. $e'));
    }
  }
}
