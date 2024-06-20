import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';
import '../widgets/movie_item.dart';

class MoviesListScreen extends StatelessWidget {
  static const routeName = '/movies-list';

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<MoviesProvider>(context);
    final movies = moviesData.movies;

    return Scaffold(
      appBar: AppBar(title: Text('Movies List')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: movies.length,
        itemBuilder: (ctx, i) => MovieItem(movies[i]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
