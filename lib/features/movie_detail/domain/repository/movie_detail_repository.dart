import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/core.dart';
import '../../data/models/models.dart';

part '../../data/repository/movie_detail_repository_impl.dart';

sealed class MovieDetailRepository {
  Future<Either<Failure, ReviewsResponse>> getMovieReviews({
    required ReviewRequest request,
  });

  Future<Either<Failure, CreditsResponse>> getMovieCredits({
    required CreditsRequest request,
  });
}
