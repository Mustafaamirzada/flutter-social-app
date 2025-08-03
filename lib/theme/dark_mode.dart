// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      inverseSurface: Colors.grey.shade300,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700,
      inversePrimary: Colors.grey.shade300,
      tertiary: Colors.grey.shade900),
  textTheme: ThemeData.dark().textTheme.apply(
        decorationColor: Colors.grey.shade900,
        bodyColor: Colors.grey[300],
        displayColor: Colors.white,
      ),
);
