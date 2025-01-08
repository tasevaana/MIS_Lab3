import 'package:flutter/material.dart';
import 'package:lab2/providers/joke_provider.dart';
import 'package:lab2/screens/joke_list_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/random_joke_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        '/jokes-by-type': (context) => JokesByTypeScreen(),
        '/random-joke': (context) => RandomJokeScreen(),
      },
    );
  }
}