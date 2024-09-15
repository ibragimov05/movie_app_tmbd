part of 'widgets.dart';

class WatchListMovieItem extends StatelessWidget {
  final Movie movie;

  const WatchListMovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = Constants.imageBaseUrl + movie.posterPath;

    return Dismissible(
      key: ValueKey(movie.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => getIt.get<WatchListBloc>().add(
            ToggleWatchListEvent(movie: movie),
          ),
      background: Container(
        padding: AppUtils.kPaddingHor16,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Icon(Icons.delete)],
        ),
      ),
      child: ZoomTapAnimation(
        onTap: () => context.pushNamed(
          Routes.movieDetail,
          pathParameters: {'movieId': movie.id.toString()},
          extra: movie,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 85,
              decoration: const BoxDecoration(
                borderRadius: AppUtils.kBorderRadius16,
              ),
              child: CacheImageNetwork(
                imageUrl: imageUrl,
                height: 130,
              ),
            ),
            AppUtils.kGap12,
            Expanded(
              child: SizedBox(
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star_outline_rounded,
                              size: 18,
                              color: Color(0xFFFF8700),
                            ),
                            AppUtils.kGap4,
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFF8700),
                              ),
                            ),
                          ],
                        ),
                        AppUtils.kGap4,
                        MovieInfoItem(
                          label: movie.genreIds.genres,
                          icon: Icons.movie,
                        ),
                        AppUtils.kGap4,
                        MovieInfoItem(
                          label: movie.releaseDate.split('-')[0],
                          icon: Icons.date_range_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
