part of '../main_page.dart';

mixin MainMixin on State<MainPage> {
  DateTime? _lastPressedAt;

  void _onPopInvoked(bool didPop, Object? result) {
    final now = DateTime.now();

    final backButtonHasNotBeenPressedOrHasBeenPressedLongTimeAgo =
        _lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2);

    if (backButtonHasNotBeenPressedOrHasBeenPressedLongTimeAgo) {
      if (context.read<TabBoxCubit>().state.tabBoxCurrentIndex != 0) {
        context.read<TabBoxCubit>().changeTabBoxIndex(newIndex: 0);
      } else {
        _lastPressedAt = now;

        context.read<TabBoxCubit>().increasePopCount();

        // TODO: add snack bar
        // AppFunctions.showSnackBar(context, context.tr('pressTwice'));
      }
    }
  }
}
