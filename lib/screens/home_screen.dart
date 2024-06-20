import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_tv/models/movie.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../providers/movies_provider.dart';
import '../widgets/movie_item.dart';
import '../screens/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;
  bool _isTrailerPlaying = false;
  int _selectedCategoryIndex = 0;
  int _selectedMovieIndex = 0;

  final List<String> _categories = ['Popular', 'TV Shows', 'My List'];

  @override
  void initState() {
    super.initState();
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    if (moviesProvider.movies.isNotEmpty) {
      _controller = VideoPlayerController.network(
        moviesProvider.movies[0].trailerUrl,
      )
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
          _controller.setLooping(true);
          _controller.setVolume(0.0); // Mute the trailer video
          _isTrailerPlaying = true;
        });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _pauseTrailer() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      _isTrailerPlaying = false;
    }
  }

  void _resumeTrailer() {
    if (!_controller.value.isPlaying && !_isTrailerPlaying) {
      _controller.play();
      _isTrailerPlaying = true;
    };
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      switch (event.logicalKey.keyLabel) {
        case 'Arrow Up':
          setState(() {
            _selectedCategoryIndex =
                (_selectedCategoryIndex - 1 + _categories.length) %
                    _categories.length;
            _selectedMovieIndex = 0;
          });
          break;
        case 'Arrow Down':
          setState(() {
            _selectedCategoryIndex =
                (_selectedCategoryIndex + 1) % _categories.length;
            _selectedMovieIndex = 0;
          });
          break;
        case 'Arrow Left':
          setState(() {
            _selectedMovieIndex =
                (_selectedMovieIndex - 1 + _getMovies().length) %
                    _getMovies().length;
          });
          break;
        case 'Arrow Right':
          setState(() {
            _selectedMovieIndex =
                (_selectedMovieIndex + 1) % _getMovies().length;
          });
          break;
        case 'Select':
        case 'Enter':
          _pauseTrailer();
          Navigator.of(context)
              .pushNamed(
                MovieDetailsScreen.routeName,
                arguments: _getMovies()[_selectedMovieIndex].id,
              )
              .then((_) {
            // Resume trailer only if it was previously playing
            _resumeTrailer();
          });
          break;
      }
    }
  }

  List<Movie> _getMovies() {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return moviesProvider.getMoviesByCategory(_categories[_selectedCategoryIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/front.png', // Replace with your logo asset
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Handle Search button action
              print('Search');
            },
          ),
          TextButton(
            onPressed: () {
              // Handle Home button action
              print('Home');
            },
            child: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle History button action
              print('History');
            },
            child: Text(
              'History',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle TV Shows button action
              print('TV Shows');
            },
            child: Text(
              'TV Shows',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle My List button action
              print('My List');
            },
            child: Text(
              'My List',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle Popular button action
              print('Popular');
            },
            child: Text(
              'Popular',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle News button action
              print('News');
            },
            child: Text(
              'News',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle Language button action
              print('Language');
            },
            child: Text(
              'Language',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: _onKey,
          autofocus: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_controller.value.isInitialized)
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
              else
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator()),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(
                  padding: const EdgeInsets.all(10.0),
                  children: _categories.map((category) {
                    return _buildCategorySection(moviesData, category);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(MoviesProvider moviesData, String category) {
    final movies = moviesData.getMoviesByCategory(category);
    final categoryIndex = _categories.indexOf(category);

    if (movies.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (ctx, i) {
              final isSelected =
                  _selectedCategoryIndex == categoryIndex && _selectedMovieIndex == i;
              return GestureDetector(
                onTap: () {
                  _pauseTrailer();
                  Navigator.of(context).pushNamed(
                    MovieDetailsScreen.routeName,
                    arguments: movies[i].id,
                  ).then((_) {
                    _resumeTrailer();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(color: Colors.blue, width: 2)
                        : null,
                  ),
                  child: MovieItem(movies[i]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
