part of 'widgets.dart';

class CacheImageNetwork extends StatelessWidget {
  final double? height;
  final double? width;
  final String imageUrl;

  const CacheImageNetwork({
    super.key,
    this.height,
    this.width,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _precacheImage(imageUrl: imageUrl, context: context),
      builder: (context, snapshot) {
        final bool imageLoaded = snapshot.data ?? false;

        return Skeletonizer(
          enabled: !imageLoaded,
          enableSwitchAnimation: true,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) =>
                AppAssets.images.popcorn.image(),
          ),
        );
      },
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
