part of '../../domain/repository/movie_detail_repository.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final Dio _dio;

  static final String _apiKey = dotenv.get('API_KEY');

  const MovieDetailRepositoryImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<Either<Failure, ReviewsResponse>> getMovieReviews({
    required ReviewRequest request,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        'movie/${request.movieId}/reviews?api_key=$_apiKey&language=en-US',
      );

      return Right<Failure, ReviewsResponse>(
        ReviewsResponse.fromJson(response.data),
      );
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");

      return Left<Failure, ReviewsResponse>(
        ServerError.withDioError(error: error).failure,
      );
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");

      return Left<Failure, ReviewsResponse>(
        ServerError.withError(message: error.toString()).failure,
      );
    }
  }

  @override
  Future<Either<Failure, CreditsResponse>> getMovieCredits({
    required CreditsRequest request,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        'movie/${request.movieId}/credits?api_key=$_apiKey',
      );

      return Right<Failure, CreditsResponse>(
        CreditsResponse.fromJson(response.data),
      );
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");

      return Left<Failure, CreditsResponse>(
        ServerError.withDioError(error: error).failure,
      );
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");

      return Left<Failure, CreditsResponse>(
        ServerError.withError(message: error.toString()).failure,
      );
    }
  }
}
