import 'dart:convert';  // For encoding/decoding data
import 'dart:io';  // For File handling
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';  // For file selection
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;  // For making HTTP requests

class CaptionGeneratorScreen extends StatefulWidget {
  const CaptionGeneratorScreen({super.key});

  @override
  _CaptionGeneratorScreenState createState() => _CaptionGeneratorScreenState();
}

class _CaptionGeneratorScreenState extends State<CaptionGeneratorScreen> {
  File? _selectedImage;
  String _captionResult = '';
  bool _isLoading = false;

  // Method to pick an image from the file system
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
          _captionResult = '';
        });
      }
    } catch (e) {
      setState(() {
        _captionResult = 'Error selecting file: $e';
      });
    }
  }

  // Method to generate a caption from the selected image using the AI model
  Future<void> _generateCaption() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
      _captionResult = '';
    });

    try {
      // Convert image to base64
      final bytes = await _selectedImage!.readAsBytes();
      String base64Image = base64Encode(bytes);

      // API endpoint and key
      final apiKey = dotenv.env['API_KEY'];
      final apiUrl = dotenv.env['API_URL'];

      // Send API request to generate a caption from the image
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
                    'mime_type': 'image/jpeg',
                    'data': base64Image,
                  }
                },
                {
                  'text': 'Generate a small caption for this image.'
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _captionResult = data['candidates'][0]['content']['parts'][0]['text'] ?? 'No caption generated.';
        });
      } else {
        setState(() {
          _captionResult = 'Error: ${response.statusCode} ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _captionResult = 'Error generating caption: $e';
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
        title: Text('Caption Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the selected image or a placeholder
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 200, fit: BoxFit.cover)
                : Icon(Icons.image, size: 100, color: Colors.grey),

            SizedBox(height: 20),

            // Button to pick an image
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Upload an Image'),
            ),

            SizedBox(height: 20),

            // Button to generate caption
            ElevatedButton(
              onPressed: _generateCaption,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Generate Caption'),
            ),

            SizedBox(height: 20),

            // Display the generated caption in a formatted manner
            _captionResult.isNotEmpty
                ? Text(
                    _captionResult,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,  // Center the caption
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
