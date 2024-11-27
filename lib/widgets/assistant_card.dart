import 'package:flutter/material.dart';

class AssistantCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final String description;
  final String imagePath;
  final double imageHeight; // Customizable image height
  final double imageWidth;  // Customizable image width
  final Color backgroundColor; // Customizable background color
  final double titleFontSize;  // Customizable title font size
  final double descriptionFontSize; // Customizable description font size

  const AssistantCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.route,
    required this.description,
    required this.imagePath,
    this.imageHeight = 100,  // Default image height
    this.imageWidth = 100,   // Default image width
    this.backgroundColor = Colors.white, // Default background color
    this.titleFontSize = 20,  // Default title font size
    this.descriptionFontSize = 16, // Default description font size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: backgroundColor, // Customizable background color
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image with customizable size
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: imageHeight,
                width: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            // Title with customizable font size
            Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),

            // Description with customizable font size
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
