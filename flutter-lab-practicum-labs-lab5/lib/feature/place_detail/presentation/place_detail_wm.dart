import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract interface class IPlaceDetailWM {
  ValueListenable<int> get currentIndex;

  PageController get pageController;

  void dispose();

  void onBackPressed();

  void onPageChanged(int index);

  void onRoutePressed();
}

final class PlaceDetailWM implements IPlaceDetailWM {
  final BuildContext _context;
  final _currentIndex = ValueNotifier<int>(0);

  @override
  final pageController = PageController();

  PlaceDetailWM({required BuildContext context}) : _context = context;

  @override
  ValueListenable<int> get currentIndex => _currentIndex;

  @override
  void dispose() {
    _currentIndex.dispose();
    pageController.dispose();
  }

  @override
  void onBackPressed() {
    unawaited(_context.router.maybePop());
  }

  @override
  void onPageChanged(int index) {
    _currentIndex.value = index;
  }

  @override
  void onRoutePressed() {
    // TODO(sugina): Реализуйте если будет подключена карта.
  }
}
