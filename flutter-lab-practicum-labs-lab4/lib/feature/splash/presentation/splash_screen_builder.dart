import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/splash/presentation/splash_model.dart';
import 'package:surf_mad_teacher_training/feature/splash/presentation/splash_screen.dart';
import 'package:surf_mad_teacher_training/feature/splash/presentation/splash_wm.dart';

@RoutePage(name: 'SplashRouteBuilder')
class SplashScreenBuilder extends StatelessWidget {
  const SplashScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashWM(context: context, model: SplashModel()),
      builder: (builderContext, __) => SplashScreen(wm: builderContext.read<SplashWM>()),
    );
  }
}
