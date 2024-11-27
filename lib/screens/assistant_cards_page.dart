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
      body: GridView.count(
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
              imageHeight: 300, // Custom image height
              imageWidth: 300,  // Custom image width
              backgroundColor: Colors.teal.shade50, // Custom background color
              titleFontSize: 22, // Custom title font size
              descriptionFontSize: 18, // Custom description font size
            ),

          AssistantCard(
            title: 'Blog from Dishes',
            icon: Icons.account_box_sharp,
            route: '/caption',
            description:
                'Create engaging blog posts based on your favorite dishes.',
            imagePath: '/Users/manya./Projects/aigenie/genie/assets/images/bd.png',
            imageHeight: 300, // Custom image height
            imageWidth: 300,  // Custom image width
            backgroundColor: Colors.teal.shade50, // Custom background color
            titleFontSize: 22, // Custom title font size
            descriptionFontSize: 18, // Custom description font size,
             // Example path
          ),
          AssistantCard(
            title: 'Recipe from Ingredients',
            icon: Icons.text_fields,
            route: '/ingredients',
            description:
                'Find recipes based on the ingredients you have at home.',
            imagePath: '/Users/manya./Projects/aigenie/genie/assets/images/ing.png',
            imageHeight: 170, // Custom image height
            imageWidth: 280,  // Custom image width
            backgroundColor: Colors.teal.shade50, // Custom background color
            titleFontSize: 22, // Custom title font size
            descriptionFontSize: 18, // Custom description f // Example path
          ),
          // Add more cards as needed...
        ],
      ),
    );
  }
}