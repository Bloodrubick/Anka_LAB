import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/places/data/repositories/places_repository.dart';
import 'package:surf_mad_teacher_training/feature/places/di/places_dependencies.dart';
import 'package:surf_mad_teacher_training/feature/places/presentation/places_list/places_model.dart';
import 'package:surf_mad_teacher_training/feature/places/presentation/places_list/places_screen.dart';
import 'package:surf_mad_teacher_training/feature/places/presentation/places_list/places_wm.dart';

/// {@template places_screen_builder.class}
/// Виджет-обёртка для PlacesScreen.
/// {@endtemplate}
class PlacesScreenBuilder extends StatelessWidget {
  /// {@macro places_screen_builder.class}
  const PlacesScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...PlacesDependencies.providers(),
        Provider(
          create:
              (createContext) => PlacesWM(
                context: createContext,
                model: PlacesModel(placesRepository: createContext.read<PlacesRepository>()),
              ),
          dispose: (_, wm) => wm.dispose(),
        ),
      ],
      builder: (builderContext, __) => PlacesScreen(wm: builderContext.read<PlacesWM>()),
    );
  }
}
