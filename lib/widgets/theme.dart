import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.blue,
  colorScheme: ColorScheme.dark().copyWith(
    secondary: Colors.cyan,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);
