import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart'; // Import flutter_markdown package

class BlogGeneratorScreen extends StatefulWidget {
  const BlogGeneratorScreen({super.key});

  @override
  _BlogGeneratorScreenState createState() => _BlogGeneratorScreenState();
}

class _BlogGeneratorScreenState extends State<BlogGeneratorScreen> {
  File? _selectedImage;
  String _blogResult = '';
  bool _isLoading = false;

  final TextEditingController _customWordLimitController = TextEditingController();
  final List<String> _wordLimits = ['200', '500', '1000', 'Custom'];
  String _selectedWordLimit = '200';

  String _selectedTone = 'Neutral';
  final List<String> _tones = ['Neutral', 'Formal', 'Friendly', 'Humorous', 'Inspirational'];

  String _selectedContentStyle = 'Descriptive';
  final List<String> _contentStyles = ['Descriptive', 'Narrative', 'Analytical', 'Persuasive'];

  // Pick image from file system
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
          _blogResult = ''; // Clear previous recipe when selecting a new image
        });
      }
    } catch (e) {
      setState(() {
        _blogResult = 'Error selecting file: $e';
      });
    }
  }


  // Generate blog using selected image and inputs
  Future<void> _generateBlog() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
      _blogResult = '';
    });

    try {
      final bytes = await _selectedImage!.readAsBytes();
      String base64Image = base64Encode(bytes);
      final apiKey = dotenv.env['API_KEY'];
      final apiUrl = dotenv.env['API_URL'];

      final wordLimit = _selectedWordLimit == 'Custom' ? _customWordLimitController.text : _selectedWordLimit;

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
                {
                  'text': 'Generate a ${_selectedTone.toLowerCase()} blog in ${_selectedContentStyle.toLowerCase()} style from this image with a word limit of $wordLimit words.'
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _blogResult = data['candidates'][0]['content']['parts'][0]['text'] ?? 'No blog generated.';
        });
      } else {
        setState(() {
          _blogResult = 'Error: ${response.statusCode} ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _blogResult = 'Error generating blog: $e';
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
      appBar: AppBar(title: Text('Blog Generator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the selected image or placeholder
            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 200, fit: BoxFit.cover)
            else
              Icon(Icons.image, size: 100, color: Colors.grey),
            SizedBox(height: 20),

            ElevatedButton(onPressed: _pickImage, child: Text('Upload Image')),
            SizedBox(height: 20),

            _buildDropdown('Select Tone', _tones, _selectedTone, (value) => setState(() => _selectedTone = value!)),
            SizedBox(height: 20),

            _buildDropdown('Select Content Style', _contentStyles, _selectedContentStyle, (value) => setState(() => _selectedContentStyle = value!)),
            SizedBox(height: 20),

            _buildDropdown('Word Limit', _wordLimits, _selectedWordLimit, (value) => setState(() => _selectedWordLimit = value!)),
            if (_selectedWordLimit == 'Custom')
              TextField(
                controller: _customWordLimitController,
                decoration: InputDecoration(labelText: 'Enter custom word limit'),
                keyboardType: TextInputType.number,
              ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _generateBlog,
              child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Generate Blog'),
            ),
            SizedBox(height: 20),

            // Display the generated blog content with markdown
            if (_blogResult.isNotEmpty)
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: MarkdownBody(
                    data: _blogResult, // This will parse and render the markdown content
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Dropdown widget for selecting options
  Widget _buildDropdown(String label, List<String> items, String selectedItem, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
    );
  }
}
