part of 'widgets.dart';

class CastItem extends StatelessWidget {
  final Cast cast;

  const CastItem({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = Constants.imageBaseUrl + cast.profilePath;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CacheImageNetwork(
            imageUrl: imageUrl,
            width: 100,
          ),
        ),
        AppUtils.kGap8,
        Text(cast.name, maxLines: 1),
      ],
    );
  }
}
