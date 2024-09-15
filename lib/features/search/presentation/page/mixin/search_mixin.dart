part of '../search_page.dart';

List<Movie> moviesBox = [];

mixin SearchMixin on State<SearchPage> {
  @override
  void initState() {
    super.initState();

    moviesBox = getIt.get<MovieBloc>().state.allMovies;
  }

  void _onChanged({required String query, required MovieState state}) {
    setState(
      () => moviesBox = state.allMovies.where(
        (element) {
          return element.title.toLowerCase().contains(query.toLowerCase());
        },
      ).toList(),
    );
  }
}
