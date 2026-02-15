import 'package:flutter/material.dart';

import '../../core/constants/ui_constants.dart';

class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppUiConstants.seedColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppUiConstants.scaffoldBackgroundColor,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }
}

