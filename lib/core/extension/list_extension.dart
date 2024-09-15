part of 'extension.dart';

extension ListIntX on List<int> {
  /// Converts ids' of movie genres into string
  /// Returns up to 3 genre names
  String get genres {
    // list of all available genres that came from database
    final List<Genre> allGenres = Constants.allGenres;

    // maximum numbers to show genres
    const int maxGenresToShow = 3;

    // 1. Filter genres
    // 2. Extract the names of these genres
    // 3. limiting result to show only [maxGenresToShow]
    // 4. convert result to list
    final List<String> genreNames = allGenres
        .where((genre) => contains(genre.id))
        .map((genre) => genre.name)
        .take(maxGenresToShow)
        .toList();

    // join the genre names with a comma and space and return it
    return genreNames.join(', ');
  }
}

extension ListMovieX on List<Movie> {
  bool isLiked({required Movie movie}) {
    return indexWhere((element) => element.id == movie.id) != -1;
  }
}
