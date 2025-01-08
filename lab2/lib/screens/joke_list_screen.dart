import 'package:flutter/material.dart';
import 'package:lab2/widgets/joke_list_tile.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';

class JokesByTypeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final String type = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jokes: $type',
          style: TextStyle(color: Colors.white), // White text for title
        ),
        backgroundColor: Colors.pink, // Pink background for AppBar
      ),
      backgroundColor: Colors.pink[50], // Light pink background for the body
      body: FutureBuilder<List<Joke>>(
        future: apiService.getJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No jokes found for type "$type"', style: TextStyle(color: Colors.white)));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return JokeListTile(joke: jokes[index]);
              },
            );
          }
        },
      ),
    );
  }
}
