import 'package:flutter/material.dart';
import '../models/movie.dart';

class MoviesProvider with ChangeNotifier {
  final List<Movie> _movies = [
    Movie(
      id: '1',
      title: 'Movie 1',
      description: 'Description for Movie 1',
      imageUrl: 'https://i1.sndcdn.com/artworks-000005011281-9brqv2-t1080x1080.jpg',
      trailerUrl: 'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      movieUrl: 'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      category: 'Popular',
    ),
    Movie(
      id: '2',
      title: 'Movie 2',
      description: 'Description for Movie 2',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_zknBiKeCfJue-g52vMLHzNZ0u2rlgkvbRaH5kHeoQoibFm92',
      trailerUrl: 'https://www.example.com/trailers/movie2.mp4',
      movieUrl: 'https://d1g6vi8lsykj44.cloudfront.net/Dunki.mp4',
      category: 'Popular',
    ),
    Movie(
      id: '3',
      title: 'Movie 3',
      description: 'Description for Movie 3',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtauzk4w5HwCXrx3nAm5VTFcywz62gV18C3A7KFT03SgB2k8c0',
      trailerUrl: 'https://www.example.com/trailers/movie3.mp4',
      movieUrl: 'https://d1g6vi8lsykj44.cloudfront.net/8K%20HDR%20_%20The%20Mirror%20Dimension%20(Spider-Man_%20No%20Way%20Home)%20_%20Dolby%205.1.mp4',
      category: 'TV Shows',
    ),
    Movie(
      id: '4',
      title: 'Movie 4',
      description: 'Description for Movie 4',
      imageUrl: 'https://www.whats-on-netflix.com/wp-content/uploads/2023/10/code-8-part-2-poster.jpg',
      trailerUrl: 'https://www.example.com/trailers/movie4.mp4',
      movieUrl: 'https://d1g6vi8lsykj44.cloudfront.net/Code.8.2019.1080p.BluRay.x265.10bit.AAC5.1-[YTS.MX].mp4',
      category: 'TV Shows',
    ),
    Movie(
      id: '5',
      title: 'Movie 5',
      description: 'Description for Movie 5',
      imageUrl: 'https://www.example.com/images/movie5.jpg',
      trailerUrl: 'https://www.example.com/trailers/movie5.mp4',
      movieUrl: 'https://www.example.com/movies/movie5.mp4',
      category: 'My List',
    ),
    Movie(
      id: '6',
      title: 'Movie 6',
      description: 'Description for Movie 6',
      imageUrl: 'https://lumiere-a.akamaihd.net/v1/images/p_toystory4_19639_917ad716.jpeg',
      trailerUrl: 'https://www.example.com/trailers/movie6.mp4',
      movieUrl: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      category: 'My List',
    ),
    // Add more movies as needed
  ];

  List<Movie> get movies {
    return [..._movies];
  }

  List<Movie> getMoviesByCategory(String category) {
    return _movies.where((movie) => movie.category == category).toList();
  }
}
