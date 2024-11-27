import 'package:flutter/material.dart';

class AssistantCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final String description; // New parameter for description
  final String imagePath; // New parameter for image path

  const AssistantCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.route,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 100), // Display the image
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}