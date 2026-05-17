import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/errors/fullscreen_error_widget.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/entities/place_card_type.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/place_card_widget.dart';
import 'package:surf_mad_teacher_training/feature/favorites/presentation/favorites_wm.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

part 'widgets/_favorites_list_widget.dart';

part 'widgets/_dismissible_wrapper.dart';

class FavoritesScreen extends StatelessWidget {
  final IFavoritesWM wm;

  const FavoritesScreen({required this.wm, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.favoritesAppBarTitle),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<PlaceEntity>>(
        valueListenable: wm.favoritesListenable,
        builder: (_, places, __) {
          return _FavoritesListWidget(
            places: places,
            onPlacePressed: wm.onPlacePressed,
            onRemovePressed: wm.onRemovePressed,
          );
        },
      ),
    );
  }
}
