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
          child: FutureBuilder(
            future: _precacheImage(imageUrl: imageUrl, context: context),
            builder: (context, snapshot) {
              final bool imageLoaded = snapshot.data ?? false;

              return Skeletonizer(
                enabled: !imageLoaded,
                enableSwitchAnimation: true,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      AppAssets.images.popcorn.image(),
                ),
              );
            },
          ),
        ),
        AppUtils.kGap8,
        Text(cast.name, maxLines: 1),
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
