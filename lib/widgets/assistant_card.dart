import 'package:flutter/material.dart';

class AssistantCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const AssistantCard({super.key, required this.title, required this.icon, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.blueAccent),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
