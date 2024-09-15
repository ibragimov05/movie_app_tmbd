import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/domain.dart';
import '../../../../../core/core.dart';
import '../../../data/models/models.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository;

  MovieBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(const MovieState()) {
    on<GetAllMoviesEvent>(_onGetAllMovies);
    on<GetGenreNamesEvent>(_onGetGenreNames);
    on<GetMovieByCategoryEvent>(_onGetMovieByCategory);
  }

  /// Handles the event to fetch all movies across different categories
  Future<void> _onGetAllMovies(
    GetAllMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    // adding event to get movie genre names
    add(const GetGenreNamesEvent());

    emit(state.copyWith(status: MovieStatus.allLoading));

    try {
      // Fetch movies for all categories concurrently
      final List<MoviesWithTotalPage> results = await Future.wait(
        Constants.categories.map(
          (category) => _fetchMoviesByCategory(category: category),
        ),
      );

      // Update state with fetched movies for each category
      final MovieState newState = state.copyWith(
        upcoming: results[0],
        popular: results[1],
        topRated: results[2],
        nowPlaying: results[3],
        status: MovieStatus.loaded,
      );

      emit(newState);
    } catch (error) {
      emit(state.copyWith(
        status: MovieStatus.error,
        error: error.toString(),
      ));
    }
  }

  /// Get all genre names
  Future<void> _onGetGenreNames(
    GetGenreNamesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final Either<Failure, GenreResponse> result =
        await _movieRepository.getMovieGenres();

    result.fold(
      (left) => debugPrint(left.message),
      (right) => Constants.allGenres = right.genres,
    );
  }

  /// Handles the event to fetch movies for a specific category
  Future<void> _onGetMovieByCategory(
    GetMovieByCategoryEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(status: MovieStatus.loading));

    try {
      final MoviesWithTotalPage result = await _fetchMoviesByCategory(
        category: event.category,
        page: event.page,
      );

      final MovieState updatedState = _updateStateForCategory(
        category: event.category,
        result: result,
      );

      emit(updatedState);
    } catch (error) {
      emit(state.copyWith(
        status: MovieStatus.error,
        error: error.toString(),
      ));
    }
  }

  /// Fetches movies for a given category and page
  Future<MoviesWithTotalPage> _fetchMoviesByCategory({
    required String category,
    int page = 1,
  }) async {
    final response = await _movieRepository.getMovies(
      request: MovieRequest(category: category, page: page),
    );

    return response.fold(
      (error) => throw Exception(error.message),
      (movieResponse) => MoviesWithTotalPage(
        movies: movieResponse.results,
        totalPage: movieResponse.totalPages,
      ),
    );
  }

  /// Updates the state for a specific category with new movie results
  MovieState _updateStateForCategory({
    required String category,
    required MoviesWithTotalPage result,
  }) {
    // Map of update functions for each category
    final Map<String, MoviesWithTotalPage Function(MoviesWithTotalPage)>
        categoryUpdates = {
      Constants.popular: (result) => state.popular.copyWith(
            movies: [...state.popular.movies, ...result.movies],
            totalPage: result.totalPage,
          ),
      Constants.topRated: (result) => state.topRated.copyWith(
            movies: [...state.topRated.movies, ...result.movies],
            totalPage: result.totalPage,
          ),
      Constants.upcoming: (result) => state.upcoming.copyWith(
            movies: [...state.upcoming.movies, ...result.movies],
            totalPage: result.totalPage,
          ),
      Constants.nowPlaying: (result) => state.nowPlaying.copyWith(
            movies: [...state.nowPlaying.movies, ...result.movies],
            totalPage: result.totalPage,
          ),
    };

    // Get the update function for the given category
    final updateFunction = categoryUpdates[category];

    if (updateFunction == null) {
      throw Exception('Invalid category: $category');
    }

    // Return updated state with new movies for the `specified` category
    return state.copyWith(
      status: MovieStatus.loaded,
      popular: category == Constants.popular ? updateFunction(result) : null,
      topRated: category == Constants.topRated ? updateFunction(result) : null,
      upcoming: category == Constants.upcoming ? updateFunction(result) : null,
      nowPlaying:
          category == Constants.nowPlaying ? updateFunction(result) : null,
    );
  }
}
