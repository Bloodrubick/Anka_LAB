import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/app/app.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_dependencies.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';

/// {@template app_builder.class}
/// Entry point for the application.
/// {@endtemplate}
class AppBuilder extends StatelessWidget {
  /// Зависимости приложения.
  final IAppScope appScope;

  /// {@macro app_builder.class}
  const AppBuilder({
    required this.appScope,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppDependencies.providers(appScope),
      child: App(),
    );
  }
}
