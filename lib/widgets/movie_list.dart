import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../screens/movie_details_screen.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          MovieDetailsScreen.routeName,
          arguments: movie.id,
        );
      },
      child: GridTile(
        child: Image.network(
          movie.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            movie.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
