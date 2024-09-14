part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final List<Movie> nowPlaying;
  final List<Movie> upcoming;
  final List<Movie> topRated;
  final List<Movie> popular;
  final MovieStatus status;
  final String? error;

  const MovieState({
    this.nowPlaying = const [],
    this.upcoming = const [],
    this.topRated = const [],
    this.popular = const [],
    this.status = MovieStatus.initial,
    this.error,
  });

  MovieState copyWith({
    List<Movie>? nowPlaying,
    List<Movie>? upcoming,
    List<Movie>? topRated,
    List<Movie>? popular,
    MovieStatus? status,
    String? error,
  }) =>
      MovieState(
        nowPlaying: nowPlaying ?? this.nowPlaying,
        upcoming: upcoming ?? this.upcoming,
        topRated: topRated ?? this.topRated,
        popular: popular ?? this.popular,
        status: status ?? this.status,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        nowPlaying,
        upcoming,
        topRated,
        popular,
        status,
        error,
      ];
}

/// enumeration for movie status
enum MovieStatus { initial, loading, loaded, allLoading, error }

/// extension to check status
extension MovieStatusX on MovieStatus {
  bool get isInitial => this == MovieStatus.initial;

  bool get isLoading => this == MovieStatus.loading;
  bool get isAllLoading => this == MovieStatus.allLoading;

  bool get isLoaded => this == MovieStatus.loaded;

  bool get isError => this == MovieStatus.error;
}

extension MovieStateX on MovieState {
  List<Movie> getMovieByCategory({required String categoryName}) {
    return switch (categoryName) {
      Constants.upcoming => upcoming,
      Constants.topRated => topRated,
      Constants.popular => popular,
      Constants.nowPlaying => nowPlaying,
      _ => [],
    };
  }
}
