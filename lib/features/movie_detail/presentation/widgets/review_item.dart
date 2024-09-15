part of 'widgets.dart';
class ReviewItem extends StatelessWidget {
  final Review review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: FutureBuilder(
                future: _precacheImage(
                  imageUrl:
                      Constants.imageBaseUrl + review.authorDetails.avatarPath,
                  context: context,
                ),
                builder: (context, snapshot) {
                  final bool imageLoaded = snapshot.data ?? false;

                  return Skeletonizer(
                    enabled: !imageLoaded,
                    enableSwitchAnimation: true,
                    child: Image.network(
                      Constants.imageBaseUrl + review.authorDetails.avatarPath,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                      errorBuilder: (context, error, stackTrace) =>
                          AppAssets.images.popcorn.image(),
                    ),
                  );
                },
              ),
            ),
            AppUtils.kGap12,
            Text(
              review.author,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        AppUtils.kGap12,
        Text(
          review.content,
          softWrap: true,
        ),
      ],
    );
  }

  Future<bool> _precacheImage({
    required String imageUrl,
    required BuildContext context,
  }) async {
    try {
      await precacheImage(NetworkImage(imageUrl), context);
      return true;
    } catch (_) {
      return false;
    }
  }
}
