import '../../data/models/movie/movie.dart';

class MoviesWithTotalPage {
  final int totalPage;
  final List<Movie> movies;

  const MoviesWithTotalPage({
    this.totalPage = -1,
    this.movies = const [],
  });

  MoviesWithTotalPage copyWith({
    int? totalPage,
    List<Movie>? movies,
  }) =>
      MoviesWithTotalPage(
        totalPage: totalPage ?? this.totalPage,
        movies: movies ?? this.movies,
      );
}
