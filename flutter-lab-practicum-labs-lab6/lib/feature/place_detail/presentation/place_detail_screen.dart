import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/utils/extension/place_type_extension.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/entities/favorites_button_type.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/favorites_button_widget_builder.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/entities/place_card_type.dart';
import 'package:surf_mad_teacher_training/feature/place_detail/presentation/place_detail_wm.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/button_rounded.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/main_button.dart';
import 'package:surf_mad_teacher_training/uikit/images/network_image_widget.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

part 'widgets/_place_details_content.dart';
part 'widgets/_route_button_widget.dart';
part 'widgets/slider/_photo_slider_widget.dart';
part 'widgets/slider/_photo_viewing_indicator.dart';

/// {@template place_detail_screen.class}
/// Экран подробностей о месте.
/// {@endtemplate}
class PlaceDetailScreen extends StatelessWidget {
  final IPlaceDetailWM wm;
  final PlaceEntity place;

  /// {@macro place_detail_screen.class}
  const PlaceDetailScreen({required this.wm, required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    final images = place.images;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: _PhotoSliderWidget(
              images: images,
              pageController: wm.pageController,
              onBackPressed: wm.onBackPressed,
              currentIndex: wm.currentIndex,
              onPageChanged: wm.onPageChanged,
            ),
            expandedHeight: 360,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _PlaceDetailsContent(place: place),
                    SizedBox(height: 24),
                    _RouteButtonWidget(onPressed: wm.onRoutePressed),
                    SizedBox(height: 24),
                    Divider(),
                    SizedBox(height: 8),
                    IntrinsicWidth(
                      child: FavoritesButtonWidgetBuilder(
                        place: place,
                        buttonType: FavoritesButtonType.big,
                        cardType: PlaceCardType.place,
                      ),
                    ),
                    SafeArea(child: SizedBox.shrink()),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
