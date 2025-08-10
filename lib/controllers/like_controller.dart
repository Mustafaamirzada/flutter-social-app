import 'dart:convert';

import 'package:flutter_social_app/config/constants/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LikeController {
  Future likeAndDislike(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      var request = await http.post(
        Uri.parse('${Config.Basev1Url}/posts/like/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
      );
      if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'liked') {
        print(json.decode(request.body));
      } else if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'Unliked') {
        print(json.decode(request.body));
      } else {
        print(json.decode(request.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
