part of '../../domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;

  const MovieRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<Failure, MovieResponse>> getMovies({
    required MovieRequest request,
  }) async {
    try {
      final String url =
          'movie/${request.category}?language=en-US&page=${request.page}';

      final Response<dynamic> response = await _dio.get(
        request.category == Constants.upcoming
            ? _upcomingUrl(page: request.page)
            : url,
      );

      return Right<Failure, MovieResponse>(
        MovieResponse.fromJson(response.data),
      );
    } on DioException catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");

      return Left<Failure, MovieResponse>(
        ServerError.withDioError(error: error).failure,
      );
    } on Exception catch (error, stacktrace) {
      log("Exception occurred: $error stacktrace: $stacktrace");

      return Left<Failure, MovieResponse>(
        ServerError.withError(message: error.toString()).failure,
      );
    }
  }

  String _upcomingUrl({required int page}) =>
      '${Constants.upcomingRemainingUrl}page=$page&sort_by=popularity.desc&with_release_type=2|3&release_date.gte=${DateTime.now().formatDateTime}&release_date.lte=${DateTime.now().add(const Duration(days: 30)).formatDateTime}';
}
