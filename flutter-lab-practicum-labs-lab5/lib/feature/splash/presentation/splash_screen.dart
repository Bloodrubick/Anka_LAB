import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_mad_teacher_training/feature/splash/presentation/splash_wm.dart';

class SplashScreen extends StatelessWidget {
  final ISplashWM wm;

  const SplashScreen({required this.wm, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFBCCD44),
              Color(0xFF6EB84D),
            ],
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/splash_logo.svg',
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
