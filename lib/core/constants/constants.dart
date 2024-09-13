abstract class Constants {
  const Constants._();

  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';


  /// movie category
  static const String nowPlaying = 'now_playing';
  static const String popular = 'popular';
  static const String topRated = 'top_rated';
  static const String upcoming = 'discover';

  /// tab box labels
  static const List<String> tabBoxLabels = [
    'Home',
    'Search',
    'Watch list',
  ];
}
