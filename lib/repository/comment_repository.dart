import 'package:flutter_social_app/config/constants/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  Future<void> createComment(String comment, int postId) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      int? userId = pref.getInt('id');
      final url = Uri.parse("${Config.Basev1Url}/comment");
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
        body: {
          "comment": comment,
          "user_id": userId.toString(),
          "post_id": postId.toString(),
        },
      );
      print('====== Called To Comment ======');
      print('User Id is: $userId');
      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception("Server returned non-JSON data.");
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ -> Comment created successfully: ${response.body}');
      } else {
        throw Exception('Failed to Comment posts. Body: ${response.body}');
      }
    } catch (e) {
      print('Unable to create Comment For This Post: $e');
      throw Exception('Unable to create Comment For This Post: $e');
    }
  }
}

/**
 * 
 *  Future<void> createPost(String title, String desc, int userId,  File? mediaUrl) async {
    try {

      final uri = Uri.parse("${Config.Basev1Url}/posts");
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json'
        ..fields['title'] = title
        ..fields['description'] = desc
        ..fields['user_id'] = userId.toString();
      if (mediaUrl != null) {
        final filestream = await http.MultipartFile.fromPath('media_url', mediaUrl.path);
        request.files.add(filestream);
      }

      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);

      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception('Server Returned None-Json Data');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ -> Post created successfully: ${response.body}');
        // postBox.clear();
        print('✅ -> Cache Cleared successfully');
      } else {
        throw Exception('Failed to Create posts. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error Creating Post: $e');
      throw Exception('Error Creating Post: $e');
    }
  }
 */