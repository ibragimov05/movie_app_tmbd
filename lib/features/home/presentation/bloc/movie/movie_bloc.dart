import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../data/models/movie/movie.dart';
import '../../../domain/repository/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository;

  MovieBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(const MovieState()) {
    on<GetAllMoviesEvent>(_onGetAllMovies);
    on<GetMovieByCategoryEvent>(_onGetMovieByCategory);
  }

  /// Fetch all movies concurrently
  Future<void> _onGetAllMovies(
    GetAllMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(status: MovieStatus.allLoading));

    try {
      final results = await Future.wait([
        _movieRepository.getMovies(
          request: const MovieRequest(category: Constants.upcoming),
        ),
        _movieRepository.getMovies(
          request: const MovieRequest(category: Constants.popular),
        ),
        _movieRepository.getMovies(
          request: const MovieRequest(category: Constants.topRated),
        ),
        _movieRepository.getMovies(
          request: const MovieRequest(category: Constants.nowPlaying),
        ),
      ]);

      /// Extract and update state for each category
      results[0].fold(
        (error) => emit(
            state.copyWith(status: MovieStatus.error, error: error.message)),
        (upcoming) => emit(state.copyWith(upcoming: upcoming.results)),
      );
      results[1].fold(
        (error) => emit(
            state.copyWith(status: MovieStatus.error, error: error.message)),
        (popular) => emit(state.copyWith(popular: popular.results)),
      );
      results[2].fold(
        (error) => emit(
            state.copyWith(status: MovieStatus.error, error: error.message)),
        (topRated) => emit(state.copyWith(topRated: topRated.results)),
      );
      results[3].fold(
        (error) => emit(
            state.copyWith(status: MovieStatus.error, error: error.message)),
        (nowPlaying) => emit(state.copyWith(nowPlaying: nowPlaying.results)),
      );

      emit(state.copyWith(status: MovieStatus.loaded));
    } catch (error) {
      emit(state.copyWith(
        status: MovieStatus.error,
        error: error.toString(),
      ));
    }
  }

  /// Fetch a movie by category
  void _onGetMovieByCategory(GetMovieByCategoryEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(status: MovieStatus.loading));

    await _fetchMoviesByCategory(
      request: MovieRequest(category: event.category, page: event.page),
      onSuccess: (movies) {
        switch (event.category) {
          case Constants.popular:
            state.popular.addAll(movies);
            break;
          case Constants.topRated:
            state.topRated.addAll(movies);
            break;
          case Constants.upcoming:
            state.upcoming.addAll(movies);
            break;
          case Constants.nowPlaying:
            state.nowPlaying.addAll(movies);
            break;
        }
        emit(state.copyWith(status: MovieStatus.loaded));
      },
      emit: emit,
    );
  }

  /// General method to fetch movies by category
  Future<void> _fetchMoviesByCategory({
    required MovieRequest request,
    required Function(List<Movie>) onSuccess,
    required Emitter<MovieState> emit,
  }) async {
    final response = await _movieRepository.getMovies(
      request: request,
    );

    response.fold(
      (Failure error) => emit(state.copyWith(
        status: MovieStatus.error,
        error: error.message,
      )),
      (MovieResponse movieResponse) => onSuccess(movieResponse.results),
    );
  }
}
