part of '../movie_detail_page.dart';

mixin MovieDetailMixin on State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    getIt.get<MovieDetailBloc>().add(
          GetMovieReviewsEvent(movieId: widget.movie.id),
        );
    getIt.get<MovieDetailBloc>().add(
          GetMovieCastsEvent(movieId: widget.movie.id),
        );
  }
}
