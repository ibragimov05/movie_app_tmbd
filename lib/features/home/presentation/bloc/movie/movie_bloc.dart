import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/error.dart';
import '../../../data/models/movie/movie.dart';
import '../../../../../core/constants/constants.dart';
import '../../../domain/repository/movie_repository.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository;

  MovieBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(const MovieState()) {
    on<GetMovieByCategory>(_onGetMovieByCategory);
  }

  void _onGetMovieByCategory(
    GetMovieByCategory event,
    Emitter<MovieState> emit,
  ) async {
    final response = await _movieRepository.getMovies(
      request: MovieRequest(page: event.page, category: event.category),
    );

    response.fold(
      (Failure l) => emit(state.copyWith(
        status: MovieStatus.error,
        error: l.message,
      )),
      (MovieResponse r) {
        switch (event.category) {
          case Constants.popular:
            emit(state.copyWith(
              status: MovieStatus.loaded,
              popular: r.results,
            ));
          case Constants.topRated:
            emit(state.copyWith(
              status: MovieStatus.loaded,
              topRated: r.results,
            ));
          case Constants.upcoming:
            emit(state.copyWith(
              status: MovieStatus.loaded,
              upcoming: r.results,
            ));
          case Constants.nowPlaying:
            emit(state.copyWith(
              status: MovieStatus.loaded,
              nowPlaying: r.results,
            ));
        }
      },
    );
  }
}
