import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/routes.dart';

void main() {
  runApp(AiGenieApp());
}

class AiGenieApp extends StatelessWidget {
  const AiGenieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AiGenie',
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Customize your theme colors
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',             // Define initial route
      routes: appRoutes,             // Import routes from utils/routes.dart
    );
  }
}
