import 'dart:convert';
import 'package:fchat/provider/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants/config.dart';

class UserController {
  AuthProvider auth = AuthProvider();

  Future getUser() async {
    try {
      SharedPreferences pref =  await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      final response = await http.post(
        Uri.parse("${Config.Basev1Url}/users"),
        headers: {"Authorization": "Bearer $token"},
      );
      
      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception("Server returned non-JSON data.");
      }
      // Decode the JSON string into a Dart Map
      Map<String, dynamic> jsonData = json.decode(response.body);

      // Extract the token
      String email = jsonData['data']['email'];
      print(email);
    }
    catch (e) {
      return {'error': e.toString()};
    }
    
  }
}