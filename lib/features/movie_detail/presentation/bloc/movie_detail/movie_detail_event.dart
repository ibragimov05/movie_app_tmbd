part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

final class GetMovieReviewsEvent extends MovieDetailEvent {
  final int movieId;

  const GetMovieReviewsEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

final class GetMovieCastsEvent extends MovieDetailEvent {
  final int movieId;

  const GetMovieCastsEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
