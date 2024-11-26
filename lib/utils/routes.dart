import 'package:flutter/material.dart';
import 'package:genie/screens/caption_generator_screen.dart';
import 'package:genie/screens/recipe_generator_screen.dart';
import 'package:genie/screens/text_summarizer.dart';
import '../screens/home_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/recipe': (context) => RecipeGeneratorScreen(),
  '/caption': (context) => CaptionGeneratorScreen(),
  './textsummarizer':(context) =>TextSummarizerScreen(),
  // Add other routes as you create more screens
};
