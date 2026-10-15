import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light,
        useMaterial3: true,
      );

  static ThemeData get dark => ThemeData(
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.dark,
        useMaterial3: true,
      );
}
