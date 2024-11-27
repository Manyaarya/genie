import 'package:flutter/material.dart';

class AssistantCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final Color backgroundColor;
  final String imageAsset;  // Optional image asset

  const AssistantCard({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
    this.backgroundColor = Colors.teal,  // Default color
    this.imageAsset = '',  // Empty by default
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 6,
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image
            if (imageAsset.isNotEmpty)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.3,  // Adjust opacity for readability
                  child: Image.asset(imageAsset, fit: BoxFit.cover),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 60, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
