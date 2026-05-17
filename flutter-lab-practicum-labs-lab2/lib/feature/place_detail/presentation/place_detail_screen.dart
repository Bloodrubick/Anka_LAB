import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/feature/place_detail/presentation/place_detail_wm.dart';
import 'package:surf_mad_teacher_training/uikit/placeholder/todo_placeholder.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

part 'widgets/_place_details_content.dart';
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
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Scaffold(
      backgroundColor: colorTheme.scaffold,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 360,
            flexibleSpace: FlexibleSpaceBar(
              background: _PhotoSliderWidget(
                images: place.images,
                pageController: wm.pageController,
                onBackPressed: wm.onBackPressed,
                currentIndex: wm.currentIndex,
                onPageChanged: wm.onPageChanged,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _PlaceDetailsContent(place: place),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: wm.onRoutePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorTheme.accent,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions, color: colorTheme.neutralWhite),
                        const SizedBox(width: 10),
                        Text(
                          'ПОСТРОИТЬ МАРШРУТ',
                          style: textTheme.button.copyWith(color: colorTheme.neutralWhite),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: colorTheme.inactive.withOpacity(0.56)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.calendar_today, color: colorTheme.inactive),
                        label: Text(
                          'Запланировать',
                          style: textTheme.small.copyWith(color: colorTheme.inactive),
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: wm.isFavorite,
                        builder: (context, isFavorite, _) {
                          return TextButton.icon(
                            onPressed: wm.onFavoritePressed,
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(scale: animation, child: child);
                              },
                              child: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                key: ValueKey<bool>(isFavorite),
                                color: isFavorite ? Colors.red : colorTheme.textPrimary,
                              ),
                            ),
                            label: Text(
                              'В Избранное',
                              style: textTheme.small.copyWith(
                                color: isFavorite ? Colors.red : colorTheme.textPrimary,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
