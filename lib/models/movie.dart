class Movie {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String trailerUrl;
  final String movieUrl;
  final String category; // New property

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.trailerUrl,
    required this.movieUrl,
    required this.category,
  });
}
