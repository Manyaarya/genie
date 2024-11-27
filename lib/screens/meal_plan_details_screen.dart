import 'package:flutter/material.dart';

class MealPlanDetailsScreen extends StatelessWidget {
  const MealPlanDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Weekly Meal Plan'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text('Your personalized meal plan will be displayed here!'),
      ),
    );
  }
}
