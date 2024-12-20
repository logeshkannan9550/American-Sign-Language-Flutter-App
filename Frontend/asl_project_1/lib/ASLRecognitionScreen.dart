// ignore_for_file: library_prefixes, library_private_types_in_public_api, avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ASL Real-Time Recognition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ASLRecognitionScreen(),
    );
  }
}

class ASLRecognitionScreen extends StatefulWidget {
  const ASLRecognitionScreen({super.key});

  @override
  _ASLRecognitionScreenState createState() => _ASLRecognitionScreenState();
}

class _ASLRecognitionScreenState extends State<ASLRecognitionScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  String prediction = '';
  late IO.Socket socket;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initSocket();
    _initCamera();
  }

  void _initSocket() {
    socket = IO.io('http://192.168.97.233:5000',
        IO.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((_) {
      print('Connected to server');
    });

    // Listen for prediction events from server
    socket.on('prediction', (data) {
      setState(() {
        prediction = data['prediction'];
      });
    });

    socket.on('error', (data) {
      print('Error: ${data['error']}');
    });
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.first;
      _controller = CameraController(camera, ResolutionPreset.medium);
      setState(() {
        _initializeControllerFuture = _controller.initialize();
      });

      // Start the frame capture loop
      Timer.periodic(const Duration(milliseconds: 500), (timer) async {
        if (!isProcessing) {
          isProcessing = true;
          await _captureAndSendImage();
          isProcessing = false;
        }
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _captureAndSendImage() async {
    try {
      if (_initializeControllerFuture != null &&
          _controller.value.isInitialized) {
        final image = await _controller.takePicture();
        Uint8List imageBytes = await image.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        // Send the image frame to the server
        socket.emit('frame', {'input_data': base64Image});
      }
    } catch (e) {
      print('Error capturing and sending image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASL Real-Time Recognition',
            style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _initializeControllerFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      // Stylish Camera Frame with gradient border and shadow
                      Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 4, // Reduced blur radius
                              spreadRadius: 1, // Reduced spread radius
                              offset: const Offset(-3, 3),
                            ),
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.3),
                              blurRadius: 4, // Reduced blur radius
                              spreadRadius: 1, // Reduced spread radius
                              offset: const Offset(3, -3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Box shadow container
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withOpacity(0.3),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: const Offset(-3, 3),
                                      ),
                                      BoxShadow(
                                        color:
                                            Colors.blueAccent.withOpacity(0.3),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: const Offset(3, -3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(21),
                                    child: AspectRatio(
                                      aspectRatio: 1.0,
                                      child: CameraPreview(_controller),
                                    ),
                                  ),
                                ),
                                // Orange border container
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.orange,
                                        width: 3), // Orange border
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                              5), // Added space between the camera and prediction container
                      // Prediction Display with gradient shadow and curved edges
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black.withOpacity(0.7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.3),
                              blurRadius: 4, // Reduced blur radius
                              spreadRadius: 2, // Reduced spread radius
                              offset: const Offset(-3, 3),
                            ),
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 4, // Reduced blur radius
                              spreadRadius: 2, // Reduced spread radius
                              offset: const Offset(3, -3),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Predicted Sign: $prediction',
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold, // Bold text
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 1), // Added more spacing here as well
                      // Helpful Instructions for Users
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Instructions:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '• Place your hand in the center of the camera.',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '• Do not shake the phone.',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '• Use in a well-lit environment for best results.',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '• Use only your right hand for ASL hand signs.',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
