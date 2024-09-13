part of 'tab_box_cubit.dart';

class TabBoxState {
  final int tabBoxCurrentIndex;
  final int popCount;
  final bool canPop;

  const TabBoxState({
    required this.tabBoxCurrentIndex,
    required this.popCount,
    required this.canPop,
  });

  TabBoxState copyWith({
    int? tabBoxCurrentIndex,
    int? popCount,
    bool? canPop,
  }) =>
      TabBoxState(
        tabBoxCurrentIndex: tabBoxCurrentIndex ?? this.tabBoxCurrentIndex,
        popCount: popCount ?? this.popCount,
        canPop: canPop ?? this.canPop,
      );
}