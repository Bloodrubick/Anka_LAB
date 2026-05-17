import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/index/index_screen.dart';
import 'package:surf_mad_teacher_training/uikit/themes/app_theme_data.dart';

/// {@template app.class}
/// Application.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app.class}
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IndexScreen(),
      theme: AppThemeData.darkTheme,
    );
  }
}
