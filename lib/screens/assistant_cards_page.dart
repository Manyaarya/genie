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
        crossAxisCount: 1,            // 2 cards per row
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const [
          AssistantCard(title: 'Recipe Generator', icon: Icons.restaurant, route: '/recipe'),
          AssistantCard(title: 'Blog from Dishes', icon: Icons.account_box_sharp, route: '/caption'),
          AssistantCard(title: 'Recipe from ingredients', icon: Icons.text_fields, route: '/ingredients'),
          
       //   AssistantCard(title: 'Text Summarizer', icon: Icons.text_fields, route: '/textsummarizer'),
        ],
      ),
    );
  }
}
