part of 'movie_bloc.dart';

@JsonSerializable()
class MovieState extends Equatable {
  final MoviesWithTotalPage nowPlaying;
  final MoviesWithTotalPage upcoming;
  final MoviesWithTotalPage topRated;
  final MoviesWithTotalPage popular;
  final MovieStatus status;
  final String? error;

  const MovieState({
    this.nowPlaying = const MoviesWithTotalPage(),
    this.upcoming = const MoviesWithTotalPage(),
    this.topRated = const MoviesWithTotalPage(),
    this.popular = const MoviesWithTotalPage(),
    this.status = MovieStatus.initial,
    this.error,
  });

  MovieState copyWith({
    MoviesWithTotalPage? nowPlaying,
    MoviesWithTotalPage? upcoming,
    MoviesWithTotalPage? topRated,
    MoviesWithTotalPage? popular,
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

/// extension to get movies by category name
extension MovieStateX on MovieState {
  MoviesWithTotalPage getMovieByCategory({required String categoryName}) {
    return switch (categoryName) {
      Constants.upcoming => upcoming,
      Constants.topRated => topRated,
      Constants.popular => popular,
      Constants.nowPlaying => nowPlaying,
      _ => const MoviesWithTotalPage(),
    };
  }
}
