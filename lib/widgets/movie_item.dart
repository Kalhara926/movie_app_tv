import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              movie.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            movie.title,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
