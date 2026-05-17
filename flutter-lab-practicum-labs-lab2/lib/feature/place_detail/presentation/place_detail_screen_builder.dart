import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/place_detail/presentation/place_detail_screen.dart';
import 'package:surf_mad_teacher_training/feature/place_detail/presentation/place_detail_wm.dart';

/// {@template place_detail_screen_builder.class}
/// Виджет-обёртка для PlaceDetailScreen.
/// {@endtemplate}
class PlaceDetailScreenBuilder extends StatelessWidget {
  final PlaceEntity place;

  /// {@macro place_detail_screen_builder.class}
  const PlaceDetailScreenBuilder({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PlaceDetailWM(context: context),
      dispose: (_, wm) => wm.dispose(),
      builder: (builderContext, __) => PlaceDetailScreen(wm: builderContext.read<PlaceDetailWM>(), place: place),
    );
  }
}
