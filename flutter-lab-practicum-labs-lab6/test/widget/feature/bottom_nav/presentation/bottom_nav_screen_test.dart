import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';
import 'package:surf_mad_teacher_training/feature/bottom_nav/presentation/bottom_nav_screen.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/repositories/i_favorites_repository.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/domain/repositories/i_theme_mode_repository.dart';
import 'package:surf_mad_teacher_training/navigation/router.dart';
import 'package:surf_mad_teacher_training/uikit/themes/app_theme_data.dart';
import 'package:surf_mad_teacher_training/feature/filter/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/place_response_converter.dart';
import 'package:surf_mad_teacher_training/api/data/filter_places_request_dto.dart';
import '../../../../unit/feature/places/data/repositories/places_repository_test.mocks.dart' as places_mocks;

import 'bottom_nav_screen_test.mocks.dart';

@GenerateMocks([IFavoritesRepository, IThemeModeRepository])
void main() {
  late FakeAppScope mockAppScope;
  late MockIFavoritesRepository mockFavoritesRepository;
  late MockIThemeModeRepository mockThemeModeRepository;
  late AppRouter appRouter;

  setUp(() {
    mockFavoritesRepository = MockIFavoritesRepository();
    mockThemeModeRepository = MockIThemeModeRepository();
    mockAppScope = FakeAppScope(
      favoritesRepository: mockFavoritesRepository,
      themeModeRepository: mockThemeModeRepository,
    );
    appRouter = AppRouter();
    
    when(mockFavoritesRepository.favoritesStream).thenAnswer((_) => BehaviorSubject<List<PlaceEntity>>.seeded([]));
    when(mockThemeModeRepository.themeModeStream).thenAnswer((_) => BehaviorSubject<ThemeMode>.seeded(ThemeMode.light));
  });

  Widget makeTestableWidget() {
    return Provider<IAppScope>(
      create: (_) => mockAppScope,
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        theme: AppThemeData.lightTheme,
      ),
    );
  }

  group('BottomNavScreen Widget Tests', () {
    testWidgets('contains 3 navigation items', (tester) async {
      appRouter.push(const BottomNavRoute());
      await tester.pumpWidget(makeTestableWidget());
      await tester.pumpAndSettle();

      // Check for BottomNavigationBar
      final bottomNavFinder = find.byType(BottomNavigationBar);
      expect(bottomNavFinder, findsOneWidget);

      // Check that it has exactly 3 items
      final BottomNavigationBar bottomNav = tester.widget(bottomNavFinder);
      expect(bottomNav.items.length, 3);
    });
  });
}

class FakeAppScope implements IAppScope {
  @override
  final IFavoritesRepository favoritesRepository;
  
  @override
  final IThemeModeRepository themeModeRepository;

  @override
  final places_mocks.MockApiClient apiClient = places_mocks.MockApiClient(); 
  
  @override
  final places_mocks.MockIFilterStorage filterStorage = places_mocks.MockIFilterStorage();

  FakeAppScope({
    required this.favoritesRepository,
    required this.themeModeRepository,
  }) {
    when(filterStorage.getFilter()).thenAnswer((_) async => FilterPlacesRequestDto());
    when(apiClient.getPlaces()).thenAnswer((_) async => []);
    when(apiClient.getFilteredPlaces(filter: anyNamed('filter')))
        .thenAnswer((_) async => []);
  }

  @override
  get appDatabase => throw UnimplementedError();

  @override
  get dio => throw UnimplementedError();

  @override
  get favoriteFromDbConverter => throw UnimplementedError();

  @override
  get favoriteToDbConverter => throw UnimplementedError();

  @override
  get filterPlacesConverter => const FilterPlacesConverter();

  @override
  get placeResponseConverter => const PlaceResponseConverter();

  @override
  get sharedPreferences => throw UnimplementedError();
}
