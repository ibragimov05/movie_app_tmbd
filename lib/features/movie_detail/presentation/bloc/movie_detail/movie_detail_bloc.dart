import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_tmbd/core/core.dart';
import 'package:movie_app_tmbd/features/movie_detail/data/models/cast/credits_request.dart';
import 'package:movie_app_tmbd/features/movie_detail/domain/repository/movie_detail_repository.dart';

import '../../../data/models/models.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailRepository _movieDetailRepository;

  MovieDetailBloc({
    required MovieDetailRepository movieDetailRepository,
  })  : _movieDetailRepository = movieDetailRepository,
        super(const MovieDetailState()) {
    on<GetMovieReviewsEvent>(_onGetMovieReviews);
    on<GetMovieCastsEvent>(_onGetMovieCasts);
  }

  /// Fetches movie reviews by movie id
  Future<void> _onGetMovieReviews(
    GetMovieReviewsEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(status: MovieDetailStatus.loading));

    final result = await _movieDetailRepository.getMovieReviews(
      request: ReviewRequest(movieId: event.movieId),
    );

    result.fold(
      (Failure l) => emit(state.copyWith(
        status: MovieDetailStatus.error,
        error: l.message,
      )),
      (ReviewsResponse r) => emit(state.copyWith(
        reviews: r.results,
        status: MovieDetailStatus.loaded,
      )),
    );
  }

  /// Fetches movie casts by movie id
  Future<void> _onGetMovieCasts(
    GetMovieCastsEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(status: MovieDetailStatus.loading));

    final result = await _movieDetailRepository.getMovieCredits(
      request: CreditsRequest(movieId: event.movieId),
    );

    result.fold(
      (Failure l) => emit(state.copyWith(
        status: MovieDetailStatus.error,
        error: l.message,
      )),
      (CreditsResponse r) => emit(state.copyWith(
        casts: r.cast,
        status: MovieDetailStatus.loaded,
      )),
    );
  }
}
