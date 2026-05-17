import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

/// Расширение для подсветки совпадений в названии места в результатах поиска.
extension PlaceNameExtension on String {
  List<TextSpan> getNameWithKeyword(
    String keyword,
    AppColorTheme colorTheme,
    AppTextTheme textTheme,
  ) {
    final textStyle = textTheme.text.copyWith(color: colorTheme.textPrimary);
    final boldStyle = textTheme.textMedium.copyWith(color: colorTheme.textPrimary);

    if (keyword.isEmpty) {
      return [TextSpan(text: this, style: textStyle)];
    }

    final lowerCaseText = toLowerCase();
    final lowerCaseKeyword = keyword.toLowerCase();

    final spans = <TextSpan>[];
    var start = 0;
    var indexOfKeyword = lowerCaseText.indexOf(lowerCaseKeyword, start);

    while (indexOfKeyword != -1) {
      if (indexOfKeyword > start) {
        spans.add(
          TextSpan(
            text: substring(start, indexOfKeyword),
            style: textStyle,
          ),
        );
      }
      final endOfKeyword = indexOfKeyword + keyword.length;
      spans.add(
        TextSpan(
          text: substring(indexOfKeyword, endOfKeyword),
          style: boldStyle,
        ),
      );
      start = endOfKeyword;
      indexOfKeyword = lowerCaseText.indexOf(lowerCaseKeyword, start);
    }

    if (start < length) {
      spans.add(
        TextSpan(
          text: substring(start),
          style: textStyle,
        ),
      );
    }

    return spans;
  }
}
