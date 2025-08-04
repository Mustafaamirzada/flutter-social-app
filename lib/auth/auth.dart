// ignore_for_file: must_be_immutable
import 'package:flutter_social_app/auth/login_or_register.dart';
import 'package:flutter_social_app/screens/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? token = '';

  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('token');
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<AuthProvider>(
    //   builder: (context, auth, child) {
    //     return auth.isLoggedIn
    //       ? HomeScreen()
    //       : LoginOrRegister();
    //   },
    // );
    if (token != null) {
      return NavbarScreen();
    }
    else {
      return LoginOrRegister();
    }
    
  }
}


/*

i have created an authentication api with laravel 12 and use it in a flutter application
but when i logout the ui dose not update immeditly after sign out what should i do
*/