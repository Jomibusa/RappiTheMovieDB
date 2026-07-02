import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
      );
}
