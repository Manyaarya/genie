import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiGenie!'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0), // Transparent app bar for a more integrated look
        elevation: 0, // Remove shadow for a cleaner look
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'), // Path to your background image
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken), // Overlay for better text contrast
                ),
              ),
            ),
          ),
          
          // Content on top of the background image with a semi-transparent dark overlay for contrast
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4), // Add a darker semi-transparent layer for text visibility
            ),
          ),
          
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Main welcome text
                const Text(
                  'Welcome to AiGenie!',
                  style: TextStyle(
                    fontSize: 40, // Larger font for more prominence
                    fontWeight: FontWeight.bold, // Bold text
                    color: Colors.white,
                    letterSpacing: 3, // Increased letter spacing for style
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Subheading text with some context
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'AiGenie is your personal assistant powered by AI. From generating recipes to crafting blogs, we have got you covered!',
                    style: TextStyle(
                      fontSize: 18, // Larger font size for readability
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w500, // Slightly bolder text
                      height: 1.6, // Better line spacing for readability
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),

                // "Get Started" button with more style
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the AssistantCardsPage when clicked
                    Navigator.pushNamed(context, '/assistantCards');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 124, 216, 165),
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      fontSize: 16, // Slightly larger for visibility
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
