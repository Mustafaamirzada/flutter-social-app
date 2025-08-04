// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:flutter_social_app/screens/navbar_screen.dart';
import 'package:flutter_social_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_text_feild.dart';
import '../utils/helpers.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  login() async {
    print('\n ---------------------- Call To Login Function ... ------------------- \n\n');
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    // try signin
    try {
      final result = await AuthService.login(
        emailController.text,
        passwordController.text,
      );

      if (result.containsKey('data') && result['data'] != null && result['data']['token'] != null) {
        // Login Successful = proced
        showUserMessage('Login Successfuly', context);

        // pop the loading circle
        if (context.mounted) Navigator.pop(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavbarScreen(),
          ),
        );
      } else {
        final errorMessage =  result['error'] ?? result['message'] ?? 'Unknown error occurred';
        showUserMessage(errorMessage, context);
      }
    } catch (e) {
      // pop loading circle
      if (context.mounted) Navigator.pop(context);
      showUserMessage('Somthing Went Wrong: $e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.person_outline,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
        
                const SizedBox(height: 25),
        
                // app name
                Text(
                  'Computer Store Center',
                  // adding styles
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        
                const SizedBox(height: 50),
        
                // email textfeild        comes from /component/my_text_feild.dart
                MyTextfield(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
                ),
        
                const SizedBox(height: 10),
        
                // password text feild      comes from /component/my_text_feild.dart
                MyTextfield(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
        
                const SizedBox(height: 10),
        
                // forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 25),
        
                // login button       comes from /component/my_button.dart
                MyButton(
                  text: 'Login',
                  onTap: login,
                ),
        
                const SizedBox(height: 25),
        
                // don't have account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
