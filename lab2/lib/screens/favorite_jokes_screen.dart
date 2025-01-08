import 'package:flutter/material.dart';
import 'package:lab2/providers/joke_provider.dart';
import 'package:provider/provider.dart';

class FavoriteJokesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteJokes = Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Jokes',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.pink, // Set background color to pink
      ),
      body: favoriteJokes.isEmpty
          ? Center(child: Text('No favorite jokes yet!', style: TextStyle(color: Colors.black87)))
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return ListTile(
            title: Text(
              joke.setup,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87), // Set text color to dark for contrast
            ),
            subtitle: Text(
              joke.punchline,
              style: TextStyle(color: Colors.black87), // Set text color to dark for contrast
            ),
          );
        },
      ),
    );
  }
}
