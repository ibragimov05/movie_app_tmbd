part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent extends Equatable {
  const MovieEvent();
}

final class GetMovieByCategory extends MovieEvent {
  final String category;
  final int page;

  const GetMovieByCategory({
    required this.category,
    required this.page,
  });

  @override
  List<Object> get props => [];
}
