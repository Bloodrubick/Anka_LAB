import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/app/app.dart';

/// {@template app_builder.class}
/// Entry point for the application.
/// {@endtemplate}
class AppBuilder extends StatelessWidget {
  /// {@macro app_builder.class}
  const AppBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return App();
  }
}
