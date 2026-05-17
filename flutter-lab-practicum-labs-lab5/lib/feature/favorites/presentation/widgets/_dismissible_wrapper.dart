part of '../favorites_screen.dart';

const _dismissDuration = Duration(milliseconds: 200);

/// {@template _dismissible_wrapper.class}
/// Виджет-обёртка для удаление места из списка избранных мест.
/// {@endtemplate}
class _DismissibleWrapper extends StatefulWidget {
  final PlaceEntity place;
  final ValueChanged<PlaceEntity> onRemovePressed;
  final Widget child;

  /// {@macro _dismissible_wrapper.class}
  const _DismissibleWrapper({
    required this.place,
    required this.onRemovePressed,
    required this.child,
  });

  @override
  State<_DismissibleWrapper> createState() => _DismissibleWrapperState();
}

class _DismissibleWrapperState extends State<_DismissibleWrapper> {
  final isDismissed = ValueNotifier(false);

  @override
  void didUpdateWidget(covariant _DismissibleWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.place.id != widget.place.id) {
      isDismissed.value = false;
    }
  }

  @override
  void dispose() {
    isDismissed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: isDismissed,
            builder: (_, value, __) {
              return AnimatedContainer(
                duration: _dismissDuration,
                child: AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: const _DismissBackgroundCard(),
                  crossFadeState: value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: _dismissDuration,
                ),
              );
            },
          ),
          Dismissible(
            key: Key(widget.place.id.toString()),
            confirmDismiss: (_) async {
              isDismissed.value = true;

              return true;
            },
            onDismissed: (_) {
              widget.onRemovePressed(widget.place);
            },
            direction: DismissDirection.endToStart,
            resizeDuration: _dismissDuration,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

class _DismissBackgroundCard extends StatelessWidget {
  const _DismissBackgroundCard();

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return AspectRatio(
      aspectRatio: 3 / 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorTheme.error,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPictureWidget(AppSvgIcons.icBucket, color: colorTheme.neutralWhite),
                const SizedBox(height: 8),
                Text(
                  AppStrings.commonRemove,
                  style: textTheme.superSmallMedium.copyWith(color: colorTheme.neutralWhite),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
