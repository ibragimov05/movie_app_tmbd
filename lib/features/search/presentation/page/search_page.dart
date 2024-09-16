import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_tmbd/core/core.dart';

import '../widgets/widgets.dart';
import '../../../../injector_container.dart';

part '../widgets/search_page_private_widgets.dart';

part 'mixin/search_mixin.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SearchMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const _SearchText(),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              buildWhen: (previous, current) =>
                  previous.allMovies != current.allMovies,
              builder: (context, state) {
                return Column(
                  children: [
                    _SearchTextField(
                      onChanged: (String query) => _onChanged(
                        query: query,
                        state: state,
                      ),
                    ),
                    Expanded(
                      child: _FoundMovies(movies: moviesBox),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
