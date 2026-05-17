import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';
import 'package:surf_mad_teacher_training/feature/settings/presentation/settings_model.dart';
import 'package:surf_mad_teacher_training/feature/settings/presentation/settings_screen.dart';
import 'package:surf_mad_teacher_training/feature/settings/presentation/settings_wm.dart';

/// {@template settings_screen_builder.class}
/// Виджет-обёртка для SettingsScreen.
/// {@endtemplate}
class SettingsScreenBuilder extends StatelessWidget {
  /// {@macro settings_screen_builder.class}
  const SettingsScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create:
          (_) => SettingsWM(model: SettingsModel(themeModeRepository: context.read<IAppScope>().themeModeRepository)),
      dispose: (_, wm) => wm.dispose(),
      builder: (builderContext, __) => SettingsScreen(wm: builderContext.read<SettingsWM>()),
    );
  }
}
