import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_app_tmbd/core/core.dart';
import 'package:movie_app_tmbd/core/extension/datetime_extension.dart';

import '../../data/models/movie/movie.dart';

part '../../data/repository/movie_repository_impl.dart';

sealed class MovieRepository {
  Future<Either<Failure, MovieResponse>> getMovies({
    required MovieRequest request,
  });
}
