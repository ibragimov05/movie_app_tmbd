part of 'watch_list_bloc.dart';

@JsonSerializable()
class WatchListState extends Equatable {
  final List<Movie> savedMovies;
  final WatchlistStatus status;
  final String? error;

  const WatchListState({
    this.savedMovies = const [],
    this.status = WatchlistStatus.initial,
    this.error,
  });

  factory WatchListState.fromJson(Map<String, dynamic> json) =>
      _$WatchListStateFromJson(json);

  Map<String, dynamic> toJson() => _$WatchListStateToJson(this);

  WatchListState copyWith({
    List<Movie>? savedMovies,
    WatchlistStatus? status,
    String? error,
  }) =>
      WatchListState(
        savedMovies: savedMovies ?? this.savedMovies,
        status: status ?? this.status,
        error: error,
      );

  @override
  List<Object?> get props => [savedMovies, status, error];
}

enum WatchlistStatus { initial, done, error }
