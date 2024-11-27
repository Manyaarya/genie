import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';  // Import Markdown package

class RecipeFromIngredientsScreen extends StatefulWidget {
  const RecipeFromIngredientsScreen({super.key});

  @override
  _RecipeFromIngredientsScreenState createState() => _RecipeFromIngredientsScreenState();
}

class _RecipeFromIngredientsScreenState extends State<RecipeFromIngredientsScreen> {
  final TextEditingController _ingredientsController = TextEditingController();
  String _recipeResult = '';
  bool _isLoading = false;

  Future<void> _generateRecipe() async {
    final ingredients = _ingredientsController.text.trim();
    if (ingredients.isEmpty) {
      setState(() {
        _recipeResult = 'Please enter at least one ingredient.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _recipeResult = '';
    });

    try {
      final apiKey = dotenv.env['API_KEY'];
      final apiUrl = dotenv.env['API_URL'];

      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [{'text': 'Generate a recipe using these ingredients: $ingredients'}]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _recipeResult = data['candidates'][0]['content']['parts'][0]['text'] ?? 'No recipe found.';
        });
      } else {
        setState(() {
          _recipeResult = 'Error: ${response.statusCode} ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _recipeResult = 'Error generating recipe: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Generator from Ingredients'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(
                labelText: 'Enter ingredients (comma-separated)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _generateRecipe,
                icon: _isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                    : Icon(Icons.receipt),
                label: _isLoading ? Text('Generating...') : Text('Generate Recipe'),
              ),
            ),
            SizedBox(height: 20),
            if (_recipeResult.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MarkdownBody(
                        data: _recipeResult, // Display Markdown content
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
