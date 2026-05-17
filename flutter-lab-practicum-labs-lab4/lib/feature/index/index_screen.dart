import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/navigation/router.dart';

/// {@template index_screen.class}
/// Экран со списком всех экранов приложения.
/// {@endtemplate}
class IndexScreen extends StatelessWidget {
  /// {@macro index_screen.class}
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список экранов')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: () {
                unawaited(context.router.push(OnboardingRouteBuilder()));
              },
              child: Text('OnboardingScreen'),
            ),
            FilledButton(
              onPressed: () {
                unawaited(context.router.push(const PlacesRouteBuilder()));
              },
              child: Text('PlacesScreen'),
            ),
            FilledButton(
              onPressed: () {
                unawaited(
                  context.router.push(PlaceDetailRouteBuilder(place: _mockPlace)),
                );
              },
              child: Text('PlaceDetailScreen'),
            ),
            FilledButton(
              onPressed: () {
                unawaited(
                  context.router.push(const SettingsRouteBuilder()),
                );
              },
              child: Text('SettingsScreen'),
            ),
            FilledButton(
              onPressed: () {
                unawaited(
                  context.router.push(FilterRouteBuilder(initialFilter: _mockFilter)),
                );
              },
              child: Text('FilterScreen'),
            ),
            FilledButton(
              onPressed: () {
                unawaited(
                  context.router.push(const FavoritesRouteBuilder()),
                );
              },
              child: Text('FavoritesScreen'),
            ),
            FilledButton(
              onPressed: () {
                unawaited(
                  context.router.push(SearchRouteBuilder(initialFilter: _mockFilter)),
                );
              },
              child: Text('SearchScreen'),
            ),
          ],
        ),
      ),
    );
  }
}

const _mockPlace = PlaceEntity(
  id: 1,
  name: 'Государственный Эрмитаж',
  description:
      'Один из крупнейших и самых известных художественных музеев мира, расположенный в Санкт-Петербурге. Это одно из самых важных и общеизвестных мест в мире, которые обязательно стоит посетить каждому гостю. Осмотритесь вокруг, оцените масштабы и величие архитектурных картин.',
  type: PlaceType.museum,
  images: [
    'https://picsum.photos/seed/1/1000/600?random=1',
    'https://picsum.photos/seed/2/1000/600?random=2',
    'https://picsum.photos/seed/3/1000/600?random=3',
  ],
  lat: 59.9452,
  lon: 30.3245,
);

final _mockFilter = FilterPlacesEntity.createDefault().copyWith(radius: 1000, type: PlaceType.values.toSet());
