import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app_tmbd/features/home/data/models/genre/genre.dart';

import '../../../../core/core.dart';
import '../../data/models/movie/movie.dart';

part '../../data/repository/movie_repository_impl.dart';

sealed class MovieRepository {
  Future<Either<Failure, MovieResponse>> getMovies({
    required MovieRequest request,
  });

  Future<Either<Failure, GenreResponse>> getMovieGenres();
}
