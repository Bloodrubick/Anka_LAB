import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/settings/presentation/settings_wm.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

part 'widgets/_theme_switch_widget.dart';
part 'widgets/_tutorial_list_tile_widget.dart';

/// {@template settings_screen.class}
/// Экран с настройками.
/// {@endtemplate}
class SettingsScreen extends StatelessWidget {
  final ISettingsWM wm;

  /// {@macro settings_screen.class}
  const SettingsScreen({required this.wm, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text(AppStrings.settingsAppBarTitle), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ThemeSwitchWidget(isDarkThemeModeState: wm.isDarkThemeModeState, onChanged: wm.onThemeChanged),
            Divider(),
            _TutorialListTileWidget(onTutorialPressed: wm.onTutorialPressed),
            Divider(),
          ],
        ),
      ),
    );
  }
}
