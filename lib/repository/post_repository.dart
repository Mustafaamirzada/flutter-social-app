// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:flutter_social_app/models/post.dart';
import 'package:flutter_social_app/models/post_hive.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../config/constants/config.dart';

class PostRepository {
  final postBox = Hive.box<PostHiveModel>('posts');

  Future<List<Post>> getAllPosts(
  ) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');

      if (token == null) {
        throw Exception("Auth token not found in SharedPreferences.");
      }

      final response = await http.get(
        Uri.parse("${Config.Basev1Url}/posts"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        }
      );
      print('====== Called To API ===========');

      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception("Server returned non-JSON data.");
      }

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> postList = jsonData['data'];
        print(jsonData);
        return postList.map((item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load posts. Status code: ${response.statusCode}, Body: ${response.body}');
      }

    } catch (e) {
      throw Exception('Error Fetching Posts: $e');
    }
  }


  Future<void> cachePostLocally({required List<Post> posts}) async {
    var prefs = await SharedPreferences.getInstance();
    var lastUpdate = prefs.getInt('LastUpdate') ?? 0; // Get the last update time
    var currentTime = DateTime.now().millisecondsSinceEpoch; // Get the current time in milliseconds

    print('================ Cache  ============\n');
    print('Last update time: $lastUpdate\n');
    print('Current time: $currentTime\n');
    if (currentTime - lastUpdate > 3600 || postBox.isEmpty) {
    print('======== Updating Cache ==========');
    // cache posts data
    for (final post in posts) {
      postBox.put(post.id, PostHiveModel.fromApi(post));
      print('Cached Post: ${post.title}\n');
    }
      //Update the cache time
    await prefs.setInt('LastUpdate', currentTime);
    } else {
      print('Cache is Up to Date');
    }
  }

  Future<List<Post>> getLocalPosts() async {
    print('Loading Data from Cache...');
    final localPosts = postBox.values;
    print('=====  Local Posts =============\n $localPosts');
    return localPosts.map((item) => PostHiveModel.toApi(item)).toList();
  }


  Future<void> createPost(String title, String desc, File? mediaUrl) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      int? userId = pref.getInt('id');
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
      print('User Id is: $userId');

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

  Future<List<Post>> searchPost(String query) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      if (token == null) {
        throw Exception("Auth token not found in SharedPreferences.");
      }

      final response = await http.get(
        Uri.parse("${Config.Basev1Url}/posts?filter[title]=$query"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        }
      );

      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception("Server returned non-JSON data.");
      }

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> postList = jsonData['data'];
        print(jsonData);
        return postList.map((item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load posts. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error Fetching Posts: $e');
    }
  }


  Future<void> updatePost(int id, String title, String desc, File? mediaUrl) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      int? userId = pref.getInt('id');
      final uri = Uri.parse("${Config.Basev1Url}/posts/$id");
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json'
        ..fields['_method'] = 'PUT'
        ..fields['title'] = title
        ..fields['description'] = desc
        ..fields['user_id'] = userId.toString();
      if (mediaUrl != null) {
        final filestream = await http.MultipartFile.fromPath('media_url', mediaUrl.path);
        request.files.add(filestream);
      }

      final streamResponse = await request.send();
      print(request.fields);
      final response = await http.Response.fromStream(streamResponse);
      print(response.body);
      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception('Server Returned None-Json Data');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ -> Post updated successfully: ${response.body}');
      } else {
        throw Exception('Failed to Update posts. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error Updating Post: $e');
      throw Exception('Error Updating Post: $e');
    }
  }
}