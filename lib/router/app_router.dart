import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../features/home/presentation/page/home_page.dart';
import '../features/main/presentation/page/main_page.dart';
import '../features/home/data/models/movie/movie_response.dart';
import '../features/others/presentation/pages/splash/splash_page.dart';
import '../features/movie_detail/presentation/pages/movie_detail_page.dart';
import '../features/others/presentation/pages/internet_connection/internet_connection_page.dart';

part 'route_names.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.main,
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
    GoRoute(
      path: Routes.noConnection,
      name: Routes.noConnection,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const NoConnectionPage(),
    ),
  ],
);
