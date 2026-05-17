import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/presentation/theme_mode_listener.dart';

/// Общие зависимости для приложения.
abstract final class AppDependencies {
  /// Провайдеры.
  static List<SingleChildWidget> providers(IAppScope appScope) {
    return [
      Provider<IAppScope>.value(value: appScope),
      ChangeNotifierProvider<IThemeModeListener>(
        create: (_) => ThemeModeListener(themeModeRepository: appScope.themeModeRepository),
      ),
    ];
  }
}
