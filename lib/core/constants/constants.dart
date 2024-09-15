import 'package:movie_app_tmbd/features/home/data/models/genre/genre_response.dart';

abstract class Constants {
  const Constants._();

  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500/';
  static const String upcomingRemainingUrl =
      'discover/movie?include_adult=false&include_video=false&language=en-US&';

  /// movie category
  static const String nowPlaying = 'now_playing';
  static const String popular = 'popular';
  static const String topRated = 'top_rated';
  static const String upcoming = 'discover';
  static const List<String> categories = [
    upcoming,
    popular,
    topRated,
    nowPlaying,
  ];
  static const List<String> movieCategories = [
    'Now playing',
    'Upcoming',
    'Top rated',
    'Popular',
  ];

  /// tab box labels
  static const List<String> tabBoxLabels = [
    'Home',
    'Search',
    'Watch list',
  ];

  static List<Genre> allGenres = [];
}
