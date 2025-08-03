import 'package:fchat/auth/auth.dart';
import 'package:fchat/models/post_hive.dart';
import 'package:fchat/provider/auth_provider.dart';
import 'package:fchat/theme/dark_mode.dart';
import 'package:fchat/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  await Hive.initFlutter();

  //Register Adaptars
  Hive.registerAdapter(PostHiveModelAdapter());
  // key
  const postKey = 'posts';
  //Open Boxs
  await Hive.openBox<PostHiveModel>(postKey);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        home: AuthPage(),
      ),
    );
  }
}