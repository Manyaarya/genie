import 'package:flutter/material.dart';

class CaptionGeneratorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caption Generator'),
      ),
      body: Center(
        child: Text(
          'Caption Generator Coming Soon!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
