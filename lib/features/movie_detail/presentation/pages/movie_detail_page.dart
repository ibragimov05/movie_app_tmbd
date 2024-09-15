import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blocs.dart';
import '../widgets/widgets.dart';
import '../../../../core/core.dart';
import '../../../../injector_container.dart';
import '../../../home/data/models/movie/movie.dart';
import '../../../watchlist/presentation/bloc/watch_list/watch_list_bloc.dart';

part '../widgets/movie_detail_page_private_widgets.dart';

part 'mixin/movie_detail_mixin.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with MovieDetailMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<MovieDetailBloc>(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return <Widget>[
                _SliverAppBar(movie: widget.movie),
                _SliverMovieBackDropDetail(movie: widget.movie),
                const _SliverTabBar(),
              ];
            },
            body: TabBarView(
              children: [
                _AboutMovie(overview: widget.movie.overview),
                const _MovieReviews(),
                const _MovieCasts(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
