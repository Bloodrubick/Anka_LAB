import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/utils/extension/place_type_extension.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filtered_places_state.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/settings_slider_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/presentation/filter_wm.dart';
import 'package:surf_mad_teacher_training/feature/filter/utils/slider_value_extension.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/back_button_widget.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/entity/button_state.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/main_button.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/text_button_widget.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

part 'widgets/_categories_widget_sliver.dart';
part 'widgets/_category_widget.dart';
part 'widgets/_clear_button_widget.dart';
part 'widgets/_result_button_widget.dart';
part 'widgets/_sliver_slider_widget.dart';
part 'widgets/_sliver_title_widget.dart';

/// {@template filter_screen.class}
/// Экран с фильтром.
/// {@endtemplate}
class FilterScreen extends StatelessWidget {
  final IFilterWM wm;
  final FilterPlacesEntity initialFilter;

  /// {@macro filter_screen.class}
  const FilterScreen({required this.wm, required this.initialFilter, super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: wm.placesStateListenable,
      builder: (_, state, __) {
        return IgnorePointer(
          ignoring: state is FilteredPlacesStateLoading,
          child: Scaffold(
            floatingActionButton: _ResultButtonWidget(
              placesStateListenable: wm.placesStateListenable,
              onPressed: wm.onResultPressed,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            body: CustomScrollView(
              physics:
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? const BouncingScrollPhysics()
                      : const ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  leading: BackButtonWidget(),
                  actions: [_ClearButtonWidget(onPressed: wm.onClearPressed)],
                  pinned: true,
                ),
                const _SliverTitleWidget(),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  sliver: _CategoriesWidgetSliver(
                    selectedTypesListenable: wm.selectedTypesListenable,
                    onPressed: wm.onTypePressed,
                  ),
                ),
                _SliverSliderWidget(
                  settingsSlider: wm.settingsSlider,
                  sliderValueListenable: wm.sliderValueListenable,
                  onSliderChange: wm.onSliderChange,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
