import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/index/index_screen.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/presentation/theme_mode_listener.dart';
import 'package:surf_mad_teacher_training/navigation/router.dart';
import 'package:surf_mad_teacher_training/uikit/themes/app_theme_data.dart';

/// {@template app.class}
/// Application.
/// {@endtemplate}
class App extends StatelessWidget {
  // make sure you don't initiate your router
  // inside of the build function.
  // ignore: avoid-stateless-widget-initialized-fields
  final _appRouter = AppRouter();

  /// {@macro app.class}
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IThemeModeListener>(
      builder: (_, themeMode, child) {
        return MaterialApp.router(
          routerConfig: _appRouter.config(),
          theme: themeMode.isDarkMode ? AppThemeData.darkTheme : AppThemeData.lightTheme,
        );
      },
      child: IndexScreen(),
    );
  }
}
