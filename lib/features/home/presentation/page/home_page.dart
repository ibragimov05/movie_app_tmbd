// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app_tmbd/core/utils/utils.dart';
// import 'package:movie_app_tmbd/features/main/presentation/cubit/tab_box_cubit.dart';
//
// import '../bloc/movie/movie_bloc.dart';
// import '../widgets/top_movie_widget.dart';
//
// part '../widgets/home_page_private_widgets.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  DefaultTabController(
//       length: 4,
//       child: SafeArea(
//         child: Column(
//           children: [
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
// ///// App bar
// //             AppUtils.kGap8,
// //             _AppBar(),
// //             AppUtils.kGap24,
// //
// //             /// Top movies list view
// //             _TopMoviesListView(),
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app_tmbd/core/utils/utils.dart';
import 'package:movie_app_tmbd/features/main/presentation/cubit/tab_box_cubit.dart';

import '../bloc/movie/movie_bloc.dart';
import '../widgets/top_movie_widget.dart';

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
          body: TabBarView(
            children: List.generate(
              4,
              (index) => ListView(
                padding: EdgeInsets.zero,
                children: const [
                  Text('AppConstants.text'),
                  Text('AppConstants.text'),
                  Text('AppConstants.text'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
