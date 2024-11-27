import 'package:flutter/material.dart';
import '../widgets/assistant_card.dart';

class AssistantCardsPage extends StatelessWidget {
  const AssistantCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiGenie Assistants'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 1, // Adjust to your layout preference
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          AssistantCard(
            title: 'Recipe Generator',
            icon: Icons.restaurant,
            route: '/recipe',
            description:
                'Generate delicious recipes from images or ingredients.',
            imagePath: '/Users/manya./Projects/aigenie/genie/assets/images/dish.png', // Path to your image
          ),
          AssistantCard(
            title: 'Blog from Dishes',
            icon: Icons.account_box_sharp,
            route: '/caption',
            description:
                'Create engaging blog posts based on your favorite dishes.',
            imagePath: '/Users/manya./Projects/aigenie/genie/assets/images/dish.png', // Example path
          ),
          AssistantCard(
            title: 'Recipe from Ingredients',
            icon: Icons.text_fields,
            route: '/ingredients',
            description:
                'Find recipes based on the ingredients you have at home.',
            imagePath: '/Users/manya./Projects/aigenie/genie/assets/images/dish.png', // Example path
          ),
          // Add more cards as needed...
        ],
      ),
    );
  }
}