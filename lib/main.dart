import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Input App',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.white),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _numericController = TextEditingController();
  File? _selectedFile;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diabetes Detection System',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Upload your medical data for analysis',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Text Input (Optional)',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _numericController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Numeric Input (Optional)',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload your file:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload, size: 50, color: Colors.blue),
                    const SizedBox(height: 8),
                    const Text(
                      'Drag and drop your file here, or click to select a file',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _pickFile,
                      child: const Text('Select File'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_selectedFile != null)
              Text(
                'Selected File: ${_selectedFile!.path.split('/').last}',
                style: const TextStyle(color: Colors.black),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Process inputs
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Text: ${_textController.text.isEmpty ? 'None' : _textController.text}\n'
                      'Numeric: ${_numericController.text.isEmpty ? 'None' : _numericController.text}\n'
                      'File: ${_selectedFile?.path ?? 'No file selected'}',
                    ),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
