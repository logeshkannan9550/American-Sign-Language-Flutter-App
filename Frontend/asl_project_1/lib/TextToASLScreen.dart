// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class TextToASLScreen extends StatefulWidget {
  const TextToASLScreen({super.key});

  @override
  _TextToASLScreenState createState() => _TextToASLScreenState();
}

class _TextToASLScreenState extends State<TextToASLScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _inputText;
  String? _aslImagePath;

  void _convertTextToASL() {
    // Get the input text from the user
    setState(() {
      _inputText = _controller.text
          .toUpperCase(); // Convert to uppercase to match file names
      // Set the ASL image path based on the input character
      if (_inputText != null && _inputText!.length == 1) {
        _aslImagePath =
            'assets/asl_images/$_inputText.png'; // Adjust path as needed
      } else {
        _aslImagePath = null; // Reset image if input is invalid
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text to ASL Recognition'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a letter (A-Z)',
              ),
              maxLength: 1, // Limit input to 1 character
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTextToASL,
              child: const Text('Show ASL Sign'),
            ),
            const SizedBox(height: 20),
            if (_aslImagePath != null)
              Column(
                children: [
                  Text(
                    'ASL Sign for $_inputText:',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    _aslImagePath!,
                    width: 200,
                    height: 200,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
