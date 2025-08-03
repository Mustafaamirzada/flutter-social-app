// ignore_for_file: use_build_context_synchronously
import 'package:fchat/screens/navbar_screen.dart';
import 'package:fchat/services/auth_service.dart';
import 'package:fchat/utils/helpers.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_text_feild.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  // register method
  void register() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final result = await AuthService.register(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      
      if (result['data']['token'] != null) {
        // Registration successful – proceed accordingly
        showUserMessage("Registration successful", context);
      
        // pop the loading circle
        if (context.mounted) Navigator.pop(context);
        // e.g., navigate to another page
        Navigator.push(context, MaterialPageRoute(builder: (context) => NavbarScreen()));
      } else {
        // Handle registration error from API
        showUserMessage(result['error'] ?? 'Registration failed.', context);
      }
    } catch (e) {
      // pop loading circle
      Navigator.pop(context);
      showUserMessage(e.toString(), context);
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
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
        
                const SizedBox(height: 25),
        
                // app name
                Text(
                  'Students Communication App',
                  style: TextStyle(
                    fontSize: 20,
                    // adding styles
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        
                const SizedBox(height: 50),
        
                // username text field          comes from /component/my_text_feild.dart
                MyTextfield(
                  hintText: 'User Name',
                  obscureText: false,
                  controller: usernameController,
                ),
        
                SizedBox(height: 10),
        
                // email textfeild          comes from /component/my_text_feild.dart
                MyTextfield(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
                ),
        
                const SizedBox(height: 10),
        
                // password text feild            comes from /component/my_text_feild.dart
                MyTextfield(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
        
                const SizedBox(height: 10),
        
                //confirm password feild        comes from /component/my_text_feild.dart
                MyTextfield(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  controller: confirmPwdController,
                ),
        
                const SizedBox(height: 10),
        
                // forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 25),
        
                // login button      comes from /component/my_button.dart
                MyButton(
                  text: 'Register',
                  onTap: register,
                ),
        
                const SizedBox(height: 25),
        
                // don't have account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'SignIn Here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
