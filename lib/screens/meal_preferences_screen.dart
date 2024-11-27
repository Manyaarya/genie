import 'package:flutter/material.dart';

class MealPreferencesScreen extends StatefulWidget {
  const MealPreferencesScreen({super.key});

  @override
  _MealPreferencesScreenState createState() => _MealPreferencesScreenState();
}

class _MealPreferencesScreenState extends State<MealPreferencesScreen> {
  String selectedDiet = 'Vegetarian';
  bool isGlutenFree = false;
  bool prefersVegan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Preferences'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedDiet,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDiet = newValue!;
                });
              },
              items: <String>['Vegetarian', 'Vegan', 'Non-Vegetarian']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            CheckboxListTile(
              title: const Text('Gluten-Free'),
              value: isGlutenFree,
              onChanged: (bool? newValue) {
                setState(() {
                  isGlutenFree = newValue!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Prefer Vegan Options'),
              value: prefersVegan,
              onChanged: (bool? newValue) {
                setState(() {
                  prefersVegan = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Here we could save preferences and navigate to meal plan
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
