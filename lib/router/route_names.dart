part of 'app_router.dart';

sealed class Routes {
  Routes._();

  static const String splash = '/';

  static const String home = '/home';
  static const String main = '/main';
  static const String movieDetail = '/movie-detail';
  static const String noConnection = '/no-connection';
}
