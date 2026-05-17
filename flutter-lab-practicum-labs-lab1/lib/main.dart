import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_mad_teacher_training/feature/app/app_builder.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      runApp(AppBuilder());
    },
    (error, stack) {
      // TODO(sugina): трек ошибок.
      debugPrint('🟡--------runZonedGuarded error $error stack $stack');
    },
  );
}
