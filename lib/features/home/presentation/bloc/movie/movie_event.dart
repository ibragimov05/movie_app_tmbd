part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent extends Equatable {
  const MovieEvent();
}

final class GetAllMoviesEvent extends MovieEvent {
  const GetAllMoviesEvent();

  @override
  List<Object> get props => [];
}

final class GetGenreNamesEvent extends MovieEvent {
  const GetGenreNamesEvent();

  @override
  List<Object> get props => [];
}

final class GetMovieByCategoryEvent extends MovieEvent {
  final String category;
  final int page;

  const GetMovieByCategoryEvent({
    required this.category,
    required this.page,
  });

  @override
  List<Object> get props => [];
}
