part of '../../domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;

  const MovieRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<Failure, MovieResponse>> getMovies({
    required MovieRequest request,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        'movie/${request.category}?language=en-US&page=${request.page}',
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
}
