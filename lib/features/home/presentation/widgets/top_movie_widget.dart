part of 'widgets.dart';

class TopMovieWidget extends StatelessWidget {
  final Movie movie;
  final int index;

  const TopMovieWidget({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () => context.pushNamed(
        Routes.movieDetail,
        pathParameters: {'movieId': movie.id.toString()},
        extra: movie,
      ),
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.only(
          left: index == 0 ? 16 : 0,
          right: index == 9 ? 16 : 0,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 130,
                child: Image.network(
                  Constants.imageBaseUrl + movie.posterPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return AppAssets.images.popcorn.image();
                  },
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              left: -10,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Stroke text
                  Text(
                    "${index + 1}",
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = AppColors.blue,
                    ),
                  ),
                  // Solid text
                  Text(
                    "${index + 1}",
                    style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
