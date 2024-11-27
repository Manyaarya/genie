import 'package:flutter/material.dart';
import '../widgets/assistant_card.dart';

class AssistantCardsPage extends StatelessWidget {
  const AssistantCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Features'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GridView.count(
            crossAxisCount: 1, // Adjust to your layout preference
            padding: const EdgeInsets.all(5),
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            children: [
              AssistantCard(
                title: 'Recipe Generator',
                icon: Icons.restaurant,
                route: '/recipe',
                description: 'Generate delicious recipes from images.',
                imagePath: '/Users/manya./Projects/aigenie/genie/assets/images/rg.png',
                imageHeight: 300,
                imageWidth: 300,
                backgroundColor: Colors.teal.shade50,
                titleFontSize: 22,
                descriptionFontSize: 18,
              ),
              AssistantCard(
                title: 'Blog from Dishes',
                icon: Icons.account_box_sharp,
                route: '/caption',
                description: 'Create engaging blog posts based on your favorite dishes.',
                imagePath: '/Users/manya./Projects/aigenie/genie/assets/images/bd.png',
                imageHeight: 300,
                imageWidth: 300,
                backgroundColor: Colors.teal.shade50,
                titleFontSize: 22,
                descriptionFontSize: 18,
              ),
              AssistantCard(
                title: 'Recipe from Ingredients',
                icon: Icons.text_fields,
                route: '/ingredients',
                description: 'Find recipes based on the ingredients you have at home.',
                imagePath: '/Users/manya./Projects/aigenie/genie/assets/images/ing.png',
                imageHeight: 170,
                imageWidth: 280,
                backgroundColor: Colors.teal.shade50,
                titleFontSize: 22,
                descriptionFontSize: 18,
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/mealPlanner'); // Navigate to your meal planner screen
              },
              backgroundColor: Colors.teal,
              icon: const Icon(Icons.explore),
              label: const Text(
                'Explore More',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
