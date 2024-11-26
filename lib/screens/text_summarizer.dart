import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TextSummarizerScreen extends StatefulWidget {
  const TextSummarizerScreen({super.key});

  @override
  _TextSummarizerScreenState createState() => _TextSummarizerScreenState();
}

class _TextSummarizerScreenState extends State<TextSummarizerScreen> {
  final TextEditingController _controller = TextEditingController();
  String _summaryResult = '';
  bool _isLoading = false;

  Future<void> _summarizeText() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _summaryResult = '';
    });

    try {
      final apiKey = dotenv.env['API_KEY'];
      final apiUrl = dotenv.env['API_URL'];

      // Correct payload structure for Gemini API
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': 'Summarize the following text:\n\n${_controller.text}'}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          // Extract summary from response structure
          _summaryResult = data['candidates'][0]['content']['parts'][0]['text'] ?? 'No summary available.';
        });
      } else {
        setState(() {
          _summaryResult = 'Error: ${response.statusCode} ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _summaryResult = 'Error: $e';
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
      appBar: AppBar(title: Text('Text Summarizer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter text to summarize',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _summarizeText,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Summarize Text'),
            ),
            SizedBox(height: 20),
            if (_summaryResult.isNotEmpty)
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _summaryResult,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

