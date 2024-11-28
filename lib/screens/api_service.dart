import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'meal_preferences.dart'; // Ensure this file defines MealPreferences

class ApiService {
  final String apiKey = dotenv.env['SPOONACULAR_API_KEY']!;

  // Function to get meal plans based on preferences
  Future<List<Map<String, dynamic>>> getMealPlans(MealPreferences preferences) async {
    // Build the base URL
    String url = 'https://api.spoonacular.com/mealplanner/generate?apiKey=$apiKey';

    // Add diet if specified
    if (preferences.diet.isNotEmpty) {
      url += '&diet=${Uri.encodeComponent(preferences.diet)}';
    }

    // Add cuisine if specified
    if (preferences.cuisine.isNotEmpty) {
      url += '&cuisine=${Uri.encodeComponent(preferences.cuisine)}';
    }

    // Add intolerances if any
    if (preferences.intolerances.isNotEmpty) {
      url += '&intolerances=${Uri.encodeComponent(preferences.intolerances.join(','))}';
    }

    print("Generated API URL: $url");

    try {
      final response = await http.get(Uri.parse(url));
      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Map<String, dynamic>> meals = [];

        // Check if the expected meals data is present
        if (data['week'] != null) {
  data['week'].forEach((day, dayData) {
    if (dayData['meals'] != null) {
      for (var meal in dayData['meals']) {
        meals.add({
          'day': day,
          'title': meal['title'],
          'image': meal['imageType'],
          'servings': meal['servings'],
          'sourceUrl': meal['sourceUrl'],
          'id': meal['id'],
        });
      }
    }
  });
}

        return meals;
      } else {
        print("Error: ${response.statusCode}");
        return [
          {'title': 'Failed to fetch meal plans. Please try again.'}
        ];
      }
    } catch (e) {
      print("Exception: $e");
      return [
        {'title': 'Error: Unable to fetch meal plans. Please check your connection.'}
      ];
    }
  }
}
