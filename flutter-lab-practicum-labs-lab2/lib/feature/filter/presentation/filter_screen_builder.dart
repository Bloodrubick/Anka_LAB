import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/filter/data/repositories/filter_repository.dart';
import 'package:surf_mad_teacher_training/feature/filter/di/filter_dependencies.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/presentation/filter_model.dart';
import 'package:surf_mad_teacher_training/feature/filter/presentation/filter_screen.dart';
import 'package:surf_mad_teacher_training/feature/filter/presentation/filter_wm.dart';

/// {@template filter_screen_builder.class}
/// Виджет-обёртка для FilterScreen.
/// {@endtemplate}
class FilterScreenBuilder extends StatelessWidget {
  final FilterPlacesEntity initialFilter;

  /// {@macro filter_screen_builder.class}
  const FilterScreenBuilder({required this.initialFilter, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...FilterDependencies.providers(),
        Provider(
          create:
              (createContext) => FilterWM(
                context: createContext,
                model: FilterModel(filterRepository: createContext.read<FilterRepository>()),
                initialFilter: initialFilter,
              ),
          dispose: (_, wm) => wm.dispose(),
        ),
      ],
      builder: (builderContext, _) => FilterScreen(wm: builderContext.read<FilterWM>(), initialFilter: initialFilter),
    );
  }
}
