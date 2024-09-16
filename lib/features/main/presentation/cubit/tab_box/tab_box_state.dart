part of 'tab_box_cubit.dart';

class TabBoxState extends Equatable {
  final int tabBoxCurrentIndex;
  final int popCount;
  final bool canPop;

  const TabBoxState({
    this.tabBoxCurrentIndex = 0,
    this.popCount = 0,
    this.canPop = false,
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

  @override
  List<Object> get props => [tabBoxCurrentIndex, popCount, canPop];
}
