import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/utils/extension/place_type_extension.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/errors/app_error_widget.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/errors/fullscreen_error_widget.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_keyword_entity.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_screen_state.dart';
import 'package:surf_mad_teacher_training/feature/search/presentation/search_wm.dart';
import 'package:surf_mad_teacher_training/feature/search/presentation/utils/place_name_extension.dart';
import 'package:surf_mad_teacher_training/uikit/behavior/conditional_wrapper.dart';
import 'package:surf_mad_teacher_training/uikit/behavior/lost_focus_wrapper.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/back_button_widget.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/button_rounded.dart';
import 'package:surf_mad_teacher_training/uikit/images/network_image_widget.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/loading/app_loader.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

part 'widgets/_search_bar_widget.dart';

part 'widgets/_result_widget.dart';

part 'widgets/_result_item_widget.dart';

part 'widgets/_history_widget.dart';

part 'widgets/_history_item_widget.dart';

/// {@template search_screen.class}
/// Экран с поиском мест.
/// {@endtemplate}
class SearchScreen extends StatelessWidget {
  final ISearchWM wm;

  /// {@macro search_screen.class}
  const SearchScreen({required this.wm, super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: wm.screenStateListenable,
      builder: (_, state, __) {
        return IgnorePointer(
          ignoring: state is SearchStateLoading,
          child: LostFocusWrapper(
            child: Scaffold(
              appBar: AppBar(
                leading: BackButtonWidget(),
                title: Text(AppStrings.searchAppBarTitle),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: _SearchBarWidget(
                    controller: wm.keywordsController,
                    onControllerClearPressed: wm.onSearchFieldClearPressed,
                  ),
                ),
                centerTitle: true,
              ),
              body: switch (state) {
                SearchStateLoading() => AppLoader.forScreen(),
                SearchStateFailure(:final failure) => AppErrorWidget(
                  failure,
                  onRetryPressed: wm.onSearchFieldClearPressed,
                ),
                SearchStateData(:final placesList) => _ResultWidget(
                  placesList: placesList,
                  onPressed: wm.onPlacePressed,
                  keyword: wm.keywordsController.text,
                ),
                HistoryStateData() => _HistoryWidget(
                  historyListenable: wm.historyStateListenable,
                  onPressed: wm.onSearchKeywordPressed,
                  onRemovePressed: wm.onSearchKeywordRemovePressed,
                  onHistoryClearPressed: wm.onHistoryClearPressed,
                ),
              },
            ),
          ),
        );
      },
    );
  }
}
