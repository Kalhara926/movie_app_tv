import 'package:flutter/material.dart';
import 'package:movie_app_tv/widgets/theme.dart';
import 'package:provider/provider.dart';

import 'providers/movies_provider.dart';
import 'screens/home_screen.dart';
import 'screens/movie_details_screen.dart';
import 'screens/video_play_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => MoviesProvider()),
      ],
      child: MaterialApp(
        title: 'Movie App TV',
        theme: darkTheme,
        home: HomeScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == MovieDetailsScreen.routeName) {
            final movieId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (ctx) => MovieDetailsScreen(movieId: movieId),
            );
          }
          if (settings.name == VideoPlayScreen.routeName) {
            final videoUrl = settings.arguments as String;
            return MaterialPageRoute(
              builder: (ctx) => VideoPlayScreen(videoUrl: videoUrl),
            );
          }
          return null;
        },
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
