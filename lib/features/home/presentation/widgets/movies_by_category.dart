import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_tmbd/core/utils/utils.dart';
import 'package:movie_app_tmbd/features/home/presentation/bloc/movie/movie_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MoviesByCategory extends StatefulWidget {
  final String categoryName;

  const MoviesByCategory({
    super.key,
    required this.categoryName,
  });

  @override
  State<MoviesByCategory> createState() => _MoviesByCategoryState();
}

class _MoviesByCategoryState extends State<MoviesByCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.status.isLoading,
          child: _gridView()
        );
      },
    );
  }

  Widget _gridView() => GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 0.7,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    padding: AppUtils.kPaddingHor16Ver8,
    itemBuilder: (context, index) {
      return ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: AppUtils.kBorderRadius12,
        child: Container(
          color: const Color(0xFF3A3F47),
          child: Image.network(
            ' movies[index].posterPath',
            errorBuilder: (context, error, stackTrace) {
              return AppAssets.images.popcorn.image();
            },
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}
