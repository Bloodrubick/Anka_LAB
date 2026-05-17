part of '../search_screen.dart';

/// {@template _history_widget.class}
/// Виджет для отображения списка поисковых запросов.
/// {@endtemplate}
class _HistoryWidget extends StatelessWidget {
  final ValueChanged<SearchKeywordEntity> onPressed;
  final ValueListenable<List<SearchKeywordEntity>> historyListenable;
  final ValueChanged<SearchKeywordEntity> onRemovePressed;
  final VoidCallback onHistoryClearPressed;

  /// {@macro _history_widget.class}
  const _HistoryWidget({
    required this.historyListenable,
    required this.onPressed,
    required this.onRemovePressed,
    required this.onHistoryClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: historyListenable,
      builder:
          (_, historyList, __) =>
              historyList.isEmpty
                  ? const SizedBox()
                  : ListView.separated(
                    physics:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? const BouncingScrollPhysics()
                            : const ClampingScrollPhysics(),
                    padding: EdgeInsets.only(left: 16, top: 24, right: 16),
                    itemBuilder: (_, index) {
                      final orderType =
                          index == 0
                              ? _OrderTypeItem.first
                              : historyList.length - 1 == index
                              ? _OrderTypeItem.last
                              : _OrderTypeItem.middle;

                      return _HistoryItemWidget(
                        keyword: historyList[index],
                        onPressed: onPressed,
                        onRemovePressed: onRemovePressed,
                        orderType: orderType,
                        onHistoryClearPressed: onHistoryClearPressed,
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider();
                    },
                    itemCount: historyList.length,
                  ),
    );
  }
}
