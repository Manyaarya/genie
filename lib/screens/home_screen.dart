import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiGenie'),
        centerTitle: true,
        backgroundColor: Colors.teal, // Custom background color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image at the top
            Image.asset(
              '/Users/manya./Projects/aigenie/genie/assets/images/dish.png', // Add your custom image in the assets folder
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            
            // Main welcome text
            const Text(
              'Welcome to AiGenie!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // Subheading text with some context
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'AiGenie is your personal assistant powered by AI. From generating recipes to crafting captions, we have got you covered!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            
            // "Get Started" button
            ElevatedButton(
              onPressed: () {
                // Navigate to the AssistantCardsPage when clicked
                Navigator.pushNamed(context, '/assistantCards');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), backgroundColor: Colors.teal,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Custom button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Get Started'),
            ),
            const SizedBox(height: 20),

            // Footer with a small description or extra information
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Explore the power of AI in making your life easier and more fun!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
