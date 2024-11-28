import 'package:flutter/material.dart';
import 'package:genie/screens/mealdetailscreen.dart';
import 'meal_preferences.dart';  // Import the new screen for meal details
import 'api_service.dart';  // Make sure to import the ApiService

class MealPlanDetailsScreen extends StatelessWidget {
  final MealPreferences preferences;

  const MealPlanDetailsScreen({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ApiService().getMealPlans(preferences),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Failed to fetch meal plans.'));
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
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        final meal = meals[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to meal detail screen on tap
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
                              title: Text(
                                meal['title'],
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Text('Servings: ${meal['servings']}'),
                              leading: meal['image'] != null
                                  ? Image.network(
                                      'https://spoonacular.com/recipeImages/${meal['id']}-312x231.${meal['image']}',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.fastfood),
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
          return const Center(child: Text('No meal plans found.'));
        }
      },
    );
  }
}
