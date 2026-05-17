import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/search/data/repositories/search_repository.dart';
import 'package:surf_mad_teacher_training/feature/search/di/search_dependencies.dart';
import 'package:surf_mad_teacher_training/feature/search/presentation/search_model.dart';
import 'package:surf_mad_teacher_training/feature/search/presentation/search_screen.dart';
import 'package:surf_mad_teacher_training/feature/search/presentation/search_wm.dart';

/// {@template search_screen_builder.class}
/// Виджет-обёртка для SearchScreen.
/// {@endtemplate}
@RoutePage()
class SearchScreenBuilder extends StatelessWidget {
  final FilterPlacesEntity initialFilter;

  /// {@macro search_screen_builder.class}
  const SearchScreenBuilder({required this.initialFilter, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...SearchDependencies.providers(),
        Provider(
          create:
              (createContext) => SearchWM(
                context: createContext,
                model: SearchModel(
                  searchRepository: createContext.read<SearchRepository>(),
                  initialFilter: initialFilter,
                ),
              ),
          dispose: (_, wm) => wm.dispose(),
        ),
      ],
      builder: (builderContext, _) => SearchScreen(wm: builderContext.read<SearchWM>()),
    );
  }
}
