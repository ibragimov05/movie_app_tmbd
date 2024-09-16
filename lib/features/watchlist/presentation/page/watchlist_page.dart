import 'package:flutter/material.dart';
import 'package:movie_app_tmbd/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blocs.dart';
import '../widgets/widgets.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppUtils.kGap8,
          const Center(
            child: Text(
              'Watch list',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<WatchListBloc, WatchListState>(
              builder: (context, state) {
                return state.savedMovies.isNotEmpty
                    ? ListView.separated(
                        padding: AppUtils.kPaddingHor16Ver12,
                        itemCount: state.savedMovies.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 25),
                        itemBuilder: (context, index) {
                          return WatchListMovieItem(
                            movie: state.savedMovies[index],
                          );
                        },
                      )
                    : const Center(
                        child: Text('You do not have any watchlist movies'),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
