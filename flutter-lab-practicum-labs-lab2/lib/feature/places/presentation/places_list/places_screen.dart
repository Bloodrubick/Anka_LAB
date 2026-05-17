import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/errors/app_error_widget.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/errors/fullscreen_error_widget.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/place_card_widget.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/skeleton_place_card_widget.dart';
import 'package:surf_mad_teacher_training/feature/places/domain/entities/places_state.dart';
import 'package:surf_mad_teacher_training/feature/places/presentation/places_list/places_wm.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/button_rounded.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/loading/skeleton.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

part 'widgets/_fake_search_bar_widget.dart';
part 'widgets/_places_list_widget.dart';
part 'widgets/_places_loader_widget.dart';
part 'widgets/_sliver_places_appbar.dart';

class PlacesScreen extends StatelessWidget {
  final IPlacesWM wm;

  const PlacesScreen({required this.wm, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<PlacesState>(
        valueListenable: wm.placesStateListenable,
        builder: (_, state, __) {
          return switch (state) {
            PlacesStateLoading() => const _PlacesLoaderWidget(),
            PlacesStateFailure(:final failure) => AppErrorWidget(failure, onRetryPressed: wm.onRetryPressed),
            PlacesStateData(:final places) => _PlacesListWidget(
              places: places,
              onPressed: wm.onPlacePressed,
              onRefresh: wm.onRefresh,
              onSearchPressed: wm.onSearchPressed,
              onFilterPressed: wm.onFilterPressed,
            ),
          };
        },
      ),
    );
  }
}
