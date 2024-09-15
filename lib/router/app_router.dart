import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_tmbd/features/home/data/models/movie/movie.dart';
import 'package:movie_app_tmbd/features/home/presentation/page/home_page.dart';
import 'package:movie_app_tmbd/features/main/presentation/page/main_page.dart';
import 'package:movie_app_tmbd/features/movie_detail/presentation/pages/movie_detail/movie_detail_page.dart';
import 'package:movie_app_tmbd/features/others/presentation/pages/splash/splash_page.dart';

part 'route_names.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      name: Routes.splash,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.main,
      name: Routes.main,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const MainPage(),
    ),
    GoRoute(
      path: Routes.home,
      name: Routes.home,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: "${Routes.movieDetail}/:movieId",
      name: Routes.movieDetail,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, state) {
        final movie = state.extra as Movie;
        return MovieDetailPage(movie: movie);
      },
    ),
  ],
);
