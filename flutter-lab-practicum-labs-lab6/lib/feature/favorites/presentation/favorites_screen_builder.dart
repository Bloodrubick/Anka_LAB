import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';
import 'package:surf_mad_teacher_training/feature/favorites/presentation/favorites_model.dart';
import 'package:surf_mad_teacher_training/feature/favorites/presentation/favorites_screen.dart';
import 'package:surf_mad_teacher_training/feature/favorites/presentation/favorites_wm.dart';

/// {@template favorites_screen_builder.class}
/// Виджет-обёртка для FavoritesScreen.
/// {@endtemplate}
@RoutePage()
class FavoritesScreenBuilder extends StatelessWidget {
  /// {@macro favorites_screen_builder.class}
  const FavoritesScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create:
          (createContext) => FavoritesWM(
            context: context,
            model: FavoritesModel(favoritesRepository: createContext.read<IAppScope>().favoritesRepository),
          ),
      dispose: (_, wm) => wm.dispose(),
      builder: (builderContext, __) => FavoritesScreen(wm: builderContext.read<FavoritesWM>()),
    );
  }
}
