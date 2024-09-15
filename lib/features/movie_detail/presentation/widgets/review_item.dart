part of 'widgets.dart';
class ReviewItem extends StatelessWidget {
  final Review review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        Constants.imageBaseUrl + review.authorDetails.avatarPath;
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
              child: CacheImageNetwork(
                imageUrl: imageUrl,
                height: 50,
                width: 50,
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
}
