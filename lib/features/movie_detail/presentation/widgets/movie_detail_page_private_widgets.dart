part of '../pages/movie_detail_page.dart';

class _SliverAppBar extends StatelessWidget {
  final Movie movie;

  const _SliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      // floating: false,
      // expandedHeight: 200,
      title: const Text(
        'Detail',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.bookmark),
        ),
      ],
    );
  }
}

class _SliverMovieBackDropDetail extends StatelessWidget {
  final Movie movie;

  const _SliverMovieBackDropDetail({required this.movie});

  @override
  Widget build(BuildContext context) {
    const double imageW = 85;
    const double imageH = 120;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              /// backdrop image
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: Image.network(
                  Constants.imageBaseUrl + movie.backdropPath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// movie rate
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: AppUtils.kPaddingHor8Ver4,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: AppUtils.kBorderRadius8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_outline_rounded,
                        color: Color(0xFFFF8700),
                        size: 20,
                      ),
                      AppUtils.kGap4,
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Color(0xFFFF8700),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// movie poster path
              Positioned(
                bottom: -40,
                left: 30,
                child: Container(
                  width: imageW,
                  height: imageH,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: AppUtils.kBorderRadius16,
                  ),
                  child: Image.network(
                    Constants.imageBaseUrl + movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// movie original title
              Positioned(
                bottom: -30,
                left: 40 + imageW,
                child: Text(movie.originalTitle),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MovieInfoItem(
                label: movie.releaseDate.split('-')[0],
                icon: Icons.date_range_rounded,
              ),
              Container(
                height: 20,
                width: 2,
                margin: AppUtils.kPaddingHor16,
                color: const Color(0xFF696974),
              ),
              MovieInfoItem(
                label: movie.genreIds.genres,
                icon: Icons.movie,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SliverTabBar extends StatelessWidget {
  const _SliverTabBar();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        const TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Color(0xFF3A3F47),
          tabs: [
            Tab(text: 'About Movie'),
            Tab(text: 'Reviews'),
            Tab(text: 'Cast'),
          ],
        ),
      ),
      pinned: true,
    );
  }
}

class _AboutMovie extends StatelessWidget {
  final String overview;

  const _AboutMovie({required this.overview});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppUtils.kPaddingHor16Ver8,
      child: Text(overview),
    );
  }
}

class _MovieReviews extends StatelessWidget {
  const _MovieReviews();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      buildWhen: (previous, current) =>
          previous.reviews != current.reviews ||
          current.isLoaded ||
          current.isLoading ||
          current.isError,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          );
        } else if (state.isError) {
          return Center(
            child: Text('Something went wrong: ${state.error}'),
          );
        } else if (state.isLoaded) {
          return state.reviews.isNotEmpty
              ? ListView.separated(
                  itemCount: state.reviews.length,
                  padding: AppUtils.kPaddingHor16Ver8,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                    child: Divider(),
                  ),
                  itemBuilder: (context, index) => ReviewItem(
                    review: state.reviews[index],
                  ),
                )
              : const Center(
                  child: Text('No reviews available for this movie'),
                );
        }
        return const SizedBox();
      },
    );
  }
}

class _MovieCasts extends StatelessWidget {
  const _MovieCasts();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      buildWhen: (previous, current) =>
          previous.casts != current.casts ||
          current.isLoaded ||
          current.isLoading ||
          current.isError,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          );
        } else if (state.isError) {
          return Center(
            child: Text('Something went wrong: ${state.error}'),
          );
        } else if (state.isLoaded) {
          return state.casts.isNotEmpty
              ? GridView.builder(
                  itemCount: state.casts.length,
                  padding: AppUtils.kPaddingHor16Ver8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 30,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) => CastItem(
                    cast: state.casts[index],
                  ),
                )
              : const Center(
                  child: Text('No casts available for this movie'),
                );
        }
        return const SizedBox();
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
