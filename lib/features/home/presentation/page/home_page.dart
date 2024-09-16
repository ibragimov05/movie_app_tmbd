import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home.dart';
import '../../../main/main.dart';
import '../../../../core/core.dart';

part '../widgets/home_page_private_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxIsScrolled,
          ) {
            return const [
              _SliverAppBar(),
              _SliverSearch(),
              _SliverTopMoviesListView(),
              _SliverTabBar(),
            ];
          },
          body: const TabBarView(
            children: [
              MoviesByCategory(categoryName: Constants.nowPlaying),
              MoviesByCategory(categoryName: Constants.upcoming),
              MoviesByCategory(categoryName: Constants.topRated),
              MoviesByCategory(categoryName: Constants.popular),
            ],
          ),
        ),
      ),
    );
  }
}
