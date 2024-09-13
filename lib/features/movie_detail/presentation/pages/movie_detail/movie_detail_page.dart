import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../home/data/models/movie/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final String movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    // context.pushNamed(Routes.movieDetail, pathParameters: {'movieId': movie.id.toString()});

    // context.pushNamed(
    //   Routes.movieDetail,
    //   pathParameters: {'movieId': movie.id.toString()},
    //   extra: movie
    // );

    final movie = GoRouterState.of(context).extra as Movie;

    if (kDebugMode) print(movie.id);

    return const Scaffold();
  }
}
