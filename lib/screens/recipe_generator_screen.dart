import 'package:flutter/material.dart';

class RecipeGeneratorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Generator'),
      ),
      body: Center(
        child: Text(
          'Recipe Generator Coming Soon!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
