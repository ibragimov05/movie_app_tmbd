part of 'watch_list_bloc.dart';

@immutable
sealed class WatchListEvent extends Equatable {
  const WatchListEvent();
}

final class ToggleWatchListEvent extends WatchListEvent {
  final Movie movie;

  const ToggleWatchListEvent({required this.movie});

  @override
  List<Object?> get props => [movie];
}
