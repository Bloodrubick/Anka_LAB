import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/uikit/loading/skeleton.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';

/// {@template skeleton_place_card_widget.class}
/// Карточка плейсхолдер.
/// {@endtemplate}
class SkeletonPlaceCardWidget extends StatelessWidget {
  /// {@macro skeleton_place_card_widget.class}
  const SkeletonPlaceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final background = colorTheme.inactive.withValues(alpha: 0.2);
    const borderRadius = BorderRadius.all(Radius.circular(12));

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Material(
          color: colorTheme.surface,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Stack(
                children: [
                  Skeleton(
                    width: double.infinity,
                    height: 96,
                    background: colorTheme.inactive,
                    borderRadius: BorderRadius.zero,
                  ),
                  Positioned(
                    left: 16,
                    top: 8,
                    right: 12,
                    child: Row(
                      children: [
                        Skeleton(width: 100, height: 16),
                        const Spacer(),
                        Skeleton(width: 32, height: 32, borderRadius: borderRadius),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 1,
                      child: Skeleton(height: 16, background: background, borderRadius: borderRadius),
                    ),
                    const SizedBox(height: 8),
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.8,
                      child: Skeleton(height: 16, background: background, borderRadius: borderRadius),
                    ),
                    const SizedBox(height: 16),
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.5,
                      child: Skeleton(height: 16, background: background, borderRadius: borderRadius),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
