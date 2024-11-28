import 'package:flutter/material.dart';
import 'package:genie/screens/mealdetailscreen.dart';
import 'meal_preferences.dart'; // Ensure this file defines MealPreferences
import 'api_service.dart'; // Your API service file

class MealPreferencesScreen extends StatelessWidget {
  final MealPreferences preferences;

  const MealPreferencesScreen({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ApiService().getMealPlans(preferences), // Ensure correct API method
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Failed to fetch meal plans: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final meals = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Your Weekly Meal Plan'),
              backgroundColor: Colors.teal,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Here is your personalized meal plan for the week!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        final meal = meals[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MealDetailScreen(
                                  mealId: meal['id'],
                                  title: meal['title'],
                                  image: meal['image'],
                                  servings: meal['servings'],
                                  sourceUrl: meal['sourceUrl'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: meal['image'] != null
                                  ? Image.network(
                                      'https://spoonacular.com/recipeImages/${meal['id']}-312x231.${meal['image'].split('.').last}',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.fastfood, size: 50),
                              title: Text(
                                meal['title'] ?? 'No Title',
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Text('Servings: ${meal['servings'] ?? 'N/A'}'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('No meal plans found.')),
          );
        }
      },
    );
  }
}
