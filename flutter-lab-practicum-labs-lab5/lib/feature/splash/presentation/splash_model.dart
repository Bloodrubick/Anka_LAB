import 'package:shared_preferences/shared_preferences.dart';

/// {@template splash_model}
/// Модель для SplashScreen.
/// {@endtemplate}
final class SplashModel implements ISplashModel {
  /// {@macro splash_model}
  const SplashModel();

  @override
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('first_launch') ?? true;
  }
}

abstract interface class ISplashModel {
  Future<bool> isFirstLaunch();
}
