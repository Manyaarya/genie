import 'dart:convert';  // For encoding/decoding data
import 'dart:io';  // For File handling
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';  // For file selection
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;  // For making HTTP requests



class RecipeGeneratorScreen extends StatefulWidget {
  const RecipeGeneratorScreen({super.key});

  @override
  _RecipeGeneratorScreenState createState() => _RecipeGeneratorScreenState();
}

class _RecipeGeneratorScreenState extends State<RecipeGeneratorScreen> {
  File? _selectedImage;
  String _recipeResult = '';
  bool _isLoading = false;

  // Pick an image
  Future<void> _pickImage() async {
    try {
      const XTypeGroup imageTypeGroup = XTypeGroup(
        label: 'Images',
        extensions: ['jpg', 'png', 'jpeg'],
        uniformTypeIdentifiers: ['public.image'],
      );

      final XFile? file = await openFile(acceptedTypeGroups: [imageTypeGroup]);

      if (file != null) {
        setState(() {
          _selectedImage = File(file.path);
          _recipeResult = '';  // Clear previous recipe when selecting a new image
        });
      }
    } catch (e) {
      setState(() {
        _recipeResult = 'Error selecting file: $e';
      });
    }
  }

  // Generate recipe from selected image
  Future<void> _generateRecipe() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
      _recipeResult = '';  // Clear previous recipe result
    });

    try {
      // Convert image to base64
      final bytes = await _selectedImage!.readAsBytes();
      String base64Image = base64Encode(bytes);

      // API endpoint and key
      final apiKey = dotenv.env['API_KEY'];
      final apiUrl = dotenv.env['API_URL'];

      // Construct the correct payload structure
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'inline_data': {
                    'mime_type': 'image/jpeg',  // Ensure this matches your image type
                    'data': base64Image,  // The base64-encoded image string
                  }
                },
                {
                  'text': 'Generate a recipe from this image.'
                }
              ]
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
        title: Text('Recipe Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display selected image
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 200, fit: BoxFit.cover)
                : Icon(Icons.image, size: 100, color: Colors.grey),

            SizedBox(height: 20),

            // Upload Image Button
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Upload an Image'),
            ),

            SizedBox(height: 20),

            // Generate Recipe Button
            ElevatedButton(
              onPressed: _generateRecipe,
              child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Generate Recipe'),
            ),

            SizedBox(height: 20),

            // Display the recipe result or show a loading indicator
            if (_recipeResult.isNotEmpty) ...[
              Text(
                'Generated Recipe:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _recipeResult,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Regenerate Recipe Button
              ElevatedButton(
                onPressed: _generateRecipe,  // Regenerate the recipe
                child: Text('Regenerate Recipe'),
              ),
            ] else if (!_isLoading) ...[
              Text(
                'No recipe generated yet.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
