import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/core.dart';
import '../../data/models/movie/movie.dart';
import '../bloc/movie/movie_bloc.dart';

class MoviesByCategory extends StatefulWidget {
  final String categoryName;

  const MoviesByCategory({super.key, required this.categoryName});

  @override
  State<MoviesByCategory> createState() => _MoviesByCategoryState();
}

class _MoviesByCategoryState extends State<MoviesByCategory> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (previous, current) =>
          previous.topRated != current.topRated ||
          previous.popular != current.popular ||
          previous.nowPlaying != current.nowPlaying ||
          previous.upcoming != current.upcoming ||
          current.status != previous.status,
      builder: (context, state) {
        if (state.status.isInitial) {
          return const Center(child: Text('Initial'));
        } else if (state.status.isError) {
          return Center(
            child: Text(state.error ?? 'Something went wrong'),
          );
        } else if (state.status.isLoading) {
          return _buildShimmerLoading();
        } else {
          final movies = state.getMovieByCategory(
            categoryName: widget.categoryName,
          );
          return _buildMovieGrid(movies);
        }
      },
    );
  }

  Widget _buildShimmerLoading() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: AppUtils.kPaddingHor16Ver8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.65,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => AppAssets.images.popcorn.image(
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMovieGrid(List<Movie> movies) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: movies.isNotEmpty ? movies.length + 1 : 0,
      padding: AppUtils.kPaddingHor16Ver8,
      itemBuilder: (context, index) {
        if (index == movies.length) {
          return _buildLoadMoreButton();
        }
        return _buildMovieItem(movies[index]);
      },
    );
  }

  Widget _buildLoadMoreButton() {
    return Center(
      child: TextButton(
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(AppColors.blue.withOpacity(0.5)),
        ),
        onPressed: () {
          _currentPage++;
          context.read<MovieBloc>().add(GetMovieByCategoryEvent(
                category: widget.categoryName,
                page: _currentPage,
              ));
        },
        child: const Text('Load more', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildMovieItem(Movie movie) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: AppUtils.kBorderRadius12,
      child: Container(
        color: const Color(0xFF3A3F47),
        child: FutureBuilder<bool>(
          future: _precacheImage(
              Constants.imageBaseUrl + movie.posterPath, context),
          builder: (context, snapshot) {
            final bool imageLoaded = snapshot.data ?? false;
            return Skeletonizer(
              enabled: !imageLoaded,
              enableSwitchAnimation: true,
              child: Image.network(
                Constants.imageBaseUrl + movie.posterPath,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _precacheImage(String imageUrl, BuildContext context) async {
    try {
      await precacheImage(NetworkImage(imageUrl), context);
      return true;
    } catch (e) {
      return false;
    }
  }
}
