import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract interface class IPlaceDetailWM {
  ValueListenable<int> get currentIndex;
  ValueListenable<bool> get isFavorite;

  PageController get pageController;

  void dispose();

  void onBackPressed();

  void onPageChanged(int index);

  void onRoutePressed();

  void onFavoritePressed();
}

final class PlaceDetailWM implements IPlaceDetailWM {
  final BuildContext _context;
  final _currentIndex = ValueNotifier<int>(0);
  final _isFavorite = ValueNotifier<bool>(false);

  @override
  final pageController = PageController();

  PlaceDetailWM({required BuildContext context}) : _context = context;

  @override
  ValueListenable<int> get currentIndex => _currentIndex;

  @override
  ValueListenable<bool> get isFavorite => _isFavorite;

  @override
  void dispose() {
    _currentIndex.dispose();
    _isFavorite.dispose();
    pageController.dispose();
  }

  @override
  void onBackPressed() {
    Navigator.of(_context).pop();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex.value = index;
  }

  @override
  void onRoutePressed() {
    // TODO: Implement route pressed
  }

  @override
  void onFavoritePressed() {
    _isFavorite.value = !_isFavorite.value;
  }
}
