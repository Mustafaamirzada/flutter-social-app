// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants/config.dart';

class AuthService {
  static Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.BaseUrl}/register"),
        headers: {"Accept": "application/json"},
        body: {"name": username, "email": email, "password": password},
      );

      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception("Server returned non-JSON data.");
      }

      // Decode the JSON string into a Dart Map
      Map<String, dynamic> jsonData = json.decode(response.body);

      // Extract the token
      String token = jsonData['data']['token'];
      print(token);
      int id = jsonData['data']['id'];
      String name = jsonData['data']['name'];
      String uEmail = jsonData['data']['email'];

      if (response.statusCode == 200 && token != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', token);
        pref.setInt('id', id);
        pref.setString('name', name);
        pref.setString('email', uEmail);
      }

      return jsonData;
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.BaseUrl}/login"),
        headers: {"Accept": "application/json"},
        body: {"email": email, "password": password},
      );

      if (!response.headers['content-type']!.contains('application/json')) {
        throw Exception("Server returned non-JSON data.");
      }
      print(
          '\n --------------------Send the Request...   ------------------\n\n');
      // Decode the JSON string into a Dart Map
      Map<String, dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      // Extract the token
      String token = jsonData['data']['token'];
      print(token);
      int id = jsonData['data']['id'];
      String name = jsonData['data']['name'];
      String uEmail = jsonData['data']['email'];

      if (response.statusCode == 200 && token != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', token);
        pref.setInt('id', id);
        pref.setString('name', name);
        pref.setString('email', uEmail);
      }
      return jsonData;
    } catch (e) {
      print(e);
      return {'error': e.toString()};
    }
  }

  static Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    await http.post(
      Uri.parse("${Config.BaseUrl}/logout"),
      headers: {"Authorization": "Bearer $token"},
    );
    pref.remove("token");
  }
}
