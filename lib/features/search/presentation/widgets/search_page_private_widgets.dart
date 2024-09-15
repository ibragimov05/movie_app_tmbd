part of '../page/search_page.dart';

class _SearchText extends StatelessWidget {
  const _SearchText();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppUtils.kPaddingVertical16,
      child: Center(
        child: Text(
          'Search',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _SearchTextField extends StatelessWidget {
  final void Function(String)? onChanged;

  const _SearchTextField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppUtils.kPaddingAll16,
      padding: AppUtils.kPaddingHor12,
      decoration: const BoxDecoration(
        color: Color(0xFF67686D),
        borderRadius: AppUtils.kBorderRadius16,
      ),
      child: TextField(
        onChanged: onChanged,
        autofocus: false,
        decoration: const InputDecoration(
          hintText: 'Search for movies...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _FoundMovies extends StatelessWidget {
  final List<Movie> movies;

  const _FoundMovies({required this.movies});

  @override
  Widget build(BuildContext context) {
    return movies.isNotEmpty
        ? ListView.separated(
            itemCount: movies.length,
            padding: AppUtils.kPaddingHor16Ver8,
            separatorBuilder: (context, index) => const SizedBox(
              height: 25,
              child: Divider(),
            ),
            itemBuilder: (context, index) => FoundMovieItem(
              movie: movies[index],
            ),
          )
        : const _NoMovieFound();
  }
}

class _NoMovieFound extends StatelessWidget {
  const _NoMovieFound();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssets.images.noResults.image(
              width: DeviceScreen.w(context) / 5,
            ),
            AppUtils.kGap12,
            const Text(
              'We are sorry, we can not find the movie :(',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            AppUtils.kGap8,
            const Text(
              'Find your movie by Type title, categories, years, etc ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF92929D),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
