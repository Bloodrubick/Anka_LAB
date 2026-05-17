import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/index/scaffold_screen.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/presentation/theme_mode_listener.dart';
import 'package:surf_mad_teacher_training/uikit/themes/app_theme_data.dart';

/// {@template app.class}
/// Application.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app.class}
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IThemeModeListener>(
      builder: (_, themeMode, child) {
        return MaterialApp(home: child, theme: themeMode.isDarkMode ? AppThemeData.darkTheme : AppThemeData.lightTheme);
      },
      child: ScaffoldScreen(),
    );
  }
}
