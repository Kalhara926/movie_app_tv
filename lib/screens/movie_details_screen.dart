import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/movies_provider.dart';
import '../screens/video_play_screen.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routeName = '/movie-details';
  final String movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MoviesProvider>(context, listen: false)
        .movies
        .firstWhere((movie) => movie.id == movieId);

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Image.network(
                movie.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              movie.description,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  VideoPlayScreen.routeName,
                  arguments: movie.movieUrl,
                );
              },
              child: Text('Watch Now'),
            ),
          ],
        ),
      ),
    );
  }
}
