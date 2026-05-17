import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/splash/presentation/splash_model.dart';
import 'package:surf_mad_teacher_training/navigation/router.dart';

abstract interface class ISplashWM {}

class SplashWM extends ChangeNotifier implements ISplashWM {
  final BuildContext _context;
  final ISplashModel _model;

  SplashWM({
    required BuildContext context,
    required ISplashModel model,
  }) : _context = context,
       _model = model {
    unawaited(_init());
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 1));
    final isFirstLaunch = await _model.isFirstLaunch();
    if (_context.mounted) {
      if (isFirstLaunch) {
        unawaited(_context.router.replaceAll([const OnboardingRouteBuilder()]));
      } else {
        unawaited(_context.router.replaceAll([const BottomNavRoute()]));
      }
    }
  }
}
