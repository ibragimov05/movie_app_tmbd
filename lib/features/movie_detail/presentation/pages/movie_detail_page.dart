import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../home/data/models/movie/movie.dart';
import '../widgets/widgets.dart';

part '../widgets/detail_page_private_widgets.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _SliverAppBar(movie: movie),
              _SliverMovieBackDropDetail(movie: movie),
              const _SliverTabBar(),
            ];
          },
          body: TabBarView(
            children: [
              _buildAboutMovie(),
              _buildReviews(),
              _buildCast(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutMovie() {
    return const Center(child: Text('About Movie Content'));
  }

  Widget _buildReviews() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => _buildReviewItem(),
    );
  }

  Widget _buildCast() {
    return const Center(child: Text('Cast Content'));
  }

  Widget _buildReviewItem() {
    return const ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
      ),
      title: Text('Iqbal Shafiq Rozaan'),
      subtitle: Text(
          'From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government.'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, color: Colors.amber),
          Text('8.3'),
        ],
      ),
    );
  }
}
