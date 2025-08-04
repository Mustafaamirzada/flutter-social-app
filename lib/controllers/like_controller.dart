import 'dart:convert';

import 'package:flutter_social_app/config/constants/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LikeController {
  Future likePost(int uid, int pid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      print('"user_id": $uid "post_id": $pid');
      final response = await http.post(
        Uri.parse("${Config.Basev1Url}/likes"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          // "content-type" : "multipart/form-data"
        },
        body: {"user_id": uid.toString(), "post_id": pid.toString()},
      );
      print(response.body);

      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception('Server Returned None Json Data');
      }
      if (response.statusCode == 200) {
        print('Liked Post');
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Feild to like Post: ${response.body}');
      }
    } catch (e) {
      throw Exception('Unable to Like Post: $e');
    }
  }

  Future<void> disLike(int uid, int pid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.delete(
        Uri.parse('${Config.Basev1Url}/likes'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          "user_id": uid.toString(),
          "post_id": pid.toString(),
        },
      );

      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception('Server Returned None-Json Data');
      }
    } catch (e) {
      throw Exception('Unable to Dislike Post: $e');
    }
  }
}
