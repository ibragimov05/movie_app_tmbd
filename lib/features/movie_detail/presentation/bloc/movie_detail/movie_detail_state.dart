part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetailStatus status;
  final List<Review> reviews;
  final List<Cast> casts;
  final String? error;

  const MovieDetailState({
    this.status = MovieDetailStatus.initial,
    this.reviews = const [],
    this.casts = const [],
    this.error,
  });

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    List<Review>? reviews,
    List<Cast>? casts,
    String? error,
  }) =>
      MovieDetailState(
        status: status ?? this.status,
        reviews: reviews ?? [],
        casts: casts ?? [],
        error: error,
      );

  @override
  List<Object?> get props => [status, reviews, error];
}

/// enumeration for movie detail status
enum MovieDetailStatus { initial, loading, loaded, error }

/// extension to check status
extension MovieDetailStatusX on MovieDetailState {
  bool get isInitial => status == MovieDetailStatus.initial;

  bool get isError => status == MovieDetailStatus.error;

  bool get isLoading => status == MovieDetailStatus.loading;

  bool get isLoaded => status == MovieDetailStatus.loaded;
}
