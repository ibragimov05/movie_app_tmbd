part of '../page/home_page.dart';

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar();

  @override
  Widget build(BuildContext context) => SliverAppBar(
        pinned: true,
        title: const Text(
          'What do you want to watch?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<MovieBloc>().add(
                  const GetAllMoviesEvent(),
                ),
            tooltip: 'Refresh page',
            icon: const Icon(Icons.refresh),
          ),
        ],
      );
}

class _SliverTabBar extends StatelessWidget {
  const _SliverTabBar();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        Container(
          color: AppColors.mainColor,
          child: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            dividerColor: Colors.transparent,
            indicatorColor: const Color(0xFF3A3F47),
            tabs: List.generate(
              4,
              (index) => Tab(text: Constants.movieCategories[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverSearch extends StatelessWidget {
  const _SliverSearch();

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: GestureDetector(
          onTap: () =>
              context.read<TabBoxCubit>().changeTabBoxIndex(newIndex: 1),
          child: Container(
            padding: AppUtils.kPaddingHor16Ver8,
            margin: AppUtils.kPaddingHor16Ver8,
            decoration: const BoxDecoration(
              color: Color(0xFF3A3F47),
              borderRadius: AppUtils.kBorderRadius16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF67686D),
                  ),
                ),
                AppAssets.icons.searchTextField.svg(),
              ],
            ),
          ),
        ),
      );
}

class _SliverTopMoviesListView extends StatelessWidget {
  const _SliverTopMoviesListView();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 210,
            child: BlocBuilder<MovieBloc, MovieState>(
              buildWhen: (previous, current) =>
                  previous.topRated != current.topRated,
              builder: (context, state) {
                return state.topRated.movies.isEmpty
                    ? const Center(child: Text('No top rated movies available'))
                    : ListView.separated(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => AppUtils.kGap24,
                        itemBuilder: (context, index) => TopMovieWidget(
                          movie: state.topRated.movies[index],
                          index: index,
                        ),
                      );
              },
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 40;

  @override
  double get maxExtent => 40;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
