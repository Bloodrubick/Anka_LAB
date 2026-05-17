part of '../search_screen.dart';

/// {@template _history_item_widget.class}
/// Виджет для отображения карточки поискового запроса.
/// {@endtemplate}
class _HistoryItemWidget extends StatelessWidget {
  final SearchKeywordEntity keyword;
  final ValueChanged<SearchKeywordEntity> onPressed;
  final ValueChanged<SearchKeywordEntity> onRemovePressed;
  final _OrderTypeItem orderType;
  final VoidCallback? onHistoryClearPressed;

  /// {@macro _history_item_widget.class}
  const _HistoryItemWidget({
    required this.keyword,
    required this.onPressed,
    required this.onRemovePressed,
    required this.orderType,
    required this.onHistoryClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);
    final onHistoryClearPressed = this.onHistoryClearPressed;

    final child = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onPressed(keyword),
              child: Text(
                keyword.keyword,
                style: textTheme.text.copyWith(color: colorTheme.secondaryVariant),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ButtonRounded(
            size: 40,
            backgroundColor: Colors.transparent,
            radius: 50,
            icon: AppSvgIcons.icClose,
            iconColor: colorTheme.inactive,
            onPressed: () => onRemovePressed(keyword),
          ),
        ],
      ),
    );

    return ConditionalWrapper(
      condition: orderType != _OrderTypeItem.middle,
      onAddWrapper: (widget) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (orderType == _OrderTypeItem.first) ...[
              Text(
                AppStrings.searchHistoryListTitle.toUpperCase(),
                style: textTheme.small.copyWith(color: colorTheme.inactive),
              ),
              const SizedBox(height: 4),
            ],
            widget,
            if (orderType == _OrderTypeItem.last && onHistoryClearPressed != null) ...[
              SafeArea(
                child: InkWell(
                  onTap: onHistoryClearPressed,
                  highlightColor: colorTheme.accent.withValues(alpha: 0),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      AppStrings.searchClearHistory,
                      style: textTheme.textMedium.copyWith(color: colorTheme.accent),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
      child: child,
    );
  }
}

enum _OrderTypeItem { first, middle, last }
