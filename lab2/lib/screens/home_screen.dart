import 'package:flutter/material.dart';
import 'package:lab2/screens/favorite_jokes_screen.dart';
import 'package:lab2/widgets/joke_card.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Joke> jokes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Joke Categories',
          style: TextStyle(color: Colors.white), // Set text color to black
        ),
        backgroundColor: Colors.pink, // Set background color to pink
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              // Filter the favorite jokes
              final favoriteJokes = jokes.where((j) => j.isFavorite).toList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteJokesScreen(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.pink,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/random-joke');
              },
              label: Text(
                'Random Joke',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: apiService.getJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No joke types found'));
          } else {
            final jokeTypes = snapshot.data!;
            return ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeCategoryTile(
                  category: jokeTypes[index],
                  onTap: () async {
                    final fetchedJokes = await apiService.getJokesByType(jokeTypes[index]);
                    setState(() {
                      jokes = fetchedJokes;
                    });
                    Navigator.pushNamed(
                      context,
                      '/jokes-by-type',
                      arguments: jokeTypes[index],
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
