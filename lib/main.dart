import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: "/Users/manya./Projects/aigenie/genie/.env");
    print("API Key: ${dotenv.env['API_KEY']}");
  } catch (e) {
    print("Error loading .env file: $e");
  }
  runApp(AiGenieApp());
}


class AiGenieApp extends StatelessWidget {
  const AiGenieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AiGenie',
      theme: ThemeData(
        primarySwatch: Colors.teal,  // Customize your theme colors
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',             // Define initial route
      routes: appRoutes,             // Import routes from utils/routes.dart
    );
  }
}
