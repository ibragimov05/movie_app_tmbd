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
      // flexibleSpace: FlexibleSpaceBar(
      //   title: Text('Detail'),
      //   centerTitle: true,
      //   expandedTitleScale: 1,
      //   collapseMode: CollapseMode.pin,
      //   background: Image.network(
      //     Constants.imageBaseUrl + movie.backdropPath,
      //     fit: BoxFit.cover,
      //   ),
      // ),
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
                label: movie.genreIds.toString(),
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
          tabs: [
            Tab(text: 'About Movie'),
            Tab(text: 'Reviews'),
            Tab(text: 'Cast'),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
        ),
      ),
      pinned: true,
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
