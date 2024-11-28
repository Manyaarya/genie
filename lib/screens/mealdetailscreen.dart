import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  final int mealId;
  final String title;
  final String image;
  final int servings;
  final String sourceUrl;

  const MealDetailScreen({
    super.key,
    required this.mealId,
    required this.title,
    required this.image,
    required this.servings,
    required this.sourceUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://spoonacular.com/recipeImages/$mealId-556x370.$image',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 10),
            Text(
              'Servings: $servings',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Open the meal source URL in the browser
                launch(sourceUrl);
              },
              child: const Text('View Recipe'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to open URL in the browser
  void launch(String url) {
    // This requires the url_launcher package
  }
}
