import 'package:flutter/material.dart';
import '../widgets/assistant_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiGenie'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,            // 2 cards per row
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const [
          AssistantCard(title: 'Recipe Generator', icon: Icons.restaurant, route: '/recipe'),
          AssistantCard(title: 'Caption Generator', icon: Icons.text_fields, route: '/caption'),
          AssistantCard(title: 'Text Summarizer', icon: Icons.text_fields, route: './textsummarizer'),
       
          
          // Add more cards as you add assistants
        ],
      ),
    );
  }
}
