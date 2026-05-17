part of '../search_screen.dart';

const _regExp = '[a-zA-Zа-яА-ЯёЁ0-9]';

/// {@template _search_bar_widget.class}
/// Виджет  поисковой строки.
/// {@endtemplate}
class _SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onControllerClearPressed;

  /// {@macro _search_bar_widget.class}
  const _SearchBarWidget({
    required this.controller,
    required this.onControllerClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    const border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: AppStrings.commonSearch,
          hintStyle: textTheme.text.copyWith(color: colorTheme.inactive),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          prefixIcon: SizedBox.square(
            dimension: 24,
            child: Center(child: SvgPictureWidget(AppSvgIcons.icSearch, color: colorTheme.inactive)),
          ),
          suffixIcon: ButtonRounded(
            size: 24,
            backgroundColor: Colors.transparent,
            radius: 50,
            icon: AppSvgIcons.icClear,
            iconColor: colorTheme.textPrimary,
            onPressed: onControllerClearPressed,
          ),
          filled: true,
          fillColor: colorTheme.surface,
          errorBorder: border,
          focusedBorder: border,
          focusedErrorBorder: border,
          disabledBorder: border,
          enabledBorder: border,
          border: border,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(_regExp)),
        ],
      ),
    );
  }
}
