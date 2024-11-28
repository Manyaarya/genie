import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'meal_preferences_screen.dart';
import 'meal_preferences.dart'; // Import your MealPreferences class

class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final List<Map<String, String>> sliderContent = [
    {
      'title': 'Plan Your Week',
      'description': 'Create personalized meal plans for the entire week!',
      'imagePath': 'assets/images/bd.png',
    },
    {
      'title': 'Get Recipe Suggestions',
      'description': 'Receive delicious and healthy recipe suggestions.',
      'imagePath': 'assets/images/bd.png',
    },
    {
      'title': 'Check This Out!',
      'description': 'Tap below to explore the Weekly Meal Planner.',
      'imagePath': 'assets/images/bd.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Meal Planner'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: sliderContent.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.7,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
              ),
              itemBuilder: (context, index, realIndex) {
                final item = sliderContent[index];
                return buildCarouselItem(item);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton.icon(
              onPressed: () {
                // Create a MealPreferences object with default values or user inputs
                final MealPreferences preferences = MealPreferences(
                  diet: 'balanced',       // Default or fetched value
                  cuisine: 'any',         // Default or fetched value
                  intolerances: [],       // Customize as needed
                );

                // Navigate to the preferences screen with the correct object
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealPreferencesScreen(preferences: preferences),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Explore Meal Planner'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCarouselItem(Map<String, String> item) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item['imagePath']!,
            height: 180,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            item['title']!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              item['description']!,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
