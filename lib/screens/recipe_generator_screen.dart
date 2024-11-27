import 'dart:convert'; // For encoding/decoding data
import 'dart:io'; // For File handling
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart'; // For file selection
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:share_plus/share_plus.dart'; // For sharing functionality
import 'package:path_provider/path_provider.dart'; // For local file storage

class RecipeGeneratorScreen extends StatefulWidget {
  const RecipeGeneratorScreen({super.key});

  @override
  _RecipeGeneratorScreenState createState() => _RecipeGeneratorScreenState();
}

class _RecipeGeneratorScreenState extends State<RecipeGeneratorScreen> {
  File? _selectedImage;
  String _recipeResult = '';
  bool _isLoadingImage = false;

  // Local storage functions
  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _getRecipeFile(String recipeName) async {
    final path = await _getLocalPath();
    return File('$path/$recipeName.json');
  }

  Future<void> _saveRecipe(String recipeName, String recipeContent) async {
    final file = await _getRecipeFile(recipeName);
    final Map<String, String> recipeData = {
      'name': recipeName,
      'content': recipeContent,
    };
    await file.writeAsString(jsonEncode(recipeData));
  }

  // File picking function
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
          _recipeResult = ''; // Clear previous recipe when selecting a new image
        });
      }
    } catch (e) {
      setState(() {
        _recipeResult = 'Error selecting file: $e';
      });
    }
  }

  // Recipe generation from image
  Future<void> _generateRecipeFromImage() async {
    if (_selectedImage == null) return;
    setState(() {
      _isLoadingImage = true;
      _recipeResult = ''; // Clear previous recipe result
    });
    try {
      final bytes = await _selectedImage!.readAsBytes();
      String base64Image = base64Encode(bytes);
      final apiKey = dotenv.env['API_KEY'];
      final apiUrl = dotenv.env['API_URL'];

      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'inline_data': {
                    'mime_type': 'image/jpeg',
                    'data': base64Image,
                  }
                },
                {'text': 'Generate a recipe from this image.'}
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
        _isLoadingImage = false;
      });
    }
  }

  // Function to share the recipe
  Future<void> _shareRecipe() async {
    if (_recipeResult.isNotEmpty) {
      await Share.share(_recipeResult);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No recipe to share.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Generator'),
        centerTitle: true,
        backgroundColor: Colors.teal, // Updated color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: 8,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'What the Recipe Generator Can Do',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'This tool helps you generate recipes in two easy ways:',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text('1. Generate Recipes from Photos', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      Text('2. Get Recipe Suggestions', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 8,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Upload a Dish Photo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade400, width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: (_selectedImage != null)
                                ? Image.file(_selectedImage!, height: 200, fit: BoxFit.cover)
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image, size: 100, color: Colors.grey),
                                      SizedBox(height: 10),
                                      Text('Tap to upload an image', style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: Icon(Icons.upload_file),
                            label: Text('Upload Image'),
                          ),
                          ElevatedButton.icon(
                            onPressed: _generateRecipeFromImage,
                            icon: _isLoadingImage ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2) : Icon(Icons.receipt),
                            label: _isLoadingImage ? Text('Generating...') : Text('Generate Recipe'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (_recipeResult.isNotEmpty) ...[
                Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Generated Recipe:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.all(16.0),
                              child: MarkdownBody(
                                data: _recipeResult,
                                styleSheet: MarkdownStyleSheet(
                                  p: TextStyle(fontSize: 16),
                                  strong: TextStyle(fontWeight: FontWeight.bold), // Optional: Customize bold style
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => _saveRecipe('recipe_${DateTime.now().millisecondsSinceEpoch}', _recipeResult),
                              child: Text('Save Recipe'),
                            ),
                            ElevatedButton(
                              onPressed: _shareRecipe,
                              child: Text('Share Recipe'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ] else if (!_isLoadingImage) ...[
                Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text('No recipe generated yet.', style: TextStyle(fontSize: 16), textAlign: TextAlign.center)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
