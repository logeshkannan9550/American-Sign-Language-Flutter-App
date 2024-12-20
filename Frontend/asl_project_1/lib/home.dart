// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:typed_data';
import 'ASLRecognitionScreen.dart'; // Import from the correct local file path
import 'TextToASLScreen.dart'; // Import from the correct local file path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFECEFE8),
        title: Padding(
          padding: const EdgeInsets.only(
              top: 30.0, // Space at the top
              bottom: 20.0,
              left: 50.0 // Space at the bottom
              ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align the title to the left
            children: [
              Text(
                "Sign",
                style: TextStyle(
                  color: const Color.fromRGBO(6, 168, 168, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ), // Add space between "Sign" and "Connect"
              Text(
                "Connect",
                style: TextStyle(
                  color: const Color.fromRGBO(240, 118, 30, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Spacer(), // Fills the remaining space to push the title left
            ],
          ),
        ),
        centerTitle: false, // Center the title
      ),
      backgroundColor: const Color(0xFFECEFE8),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Stack(children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 177, 243, 232),
                        shape: BoxShape.circle),
                  ),
                ),
                Container(
                  height: 155,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/hand_logo.png'))),
                )
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius:
                      BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Welcome to The Real-Time Sign Language Detection App',
                  style: GoogleFonts.tourney().copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Container(
                padding: EdgeInsets.only(top: 10, bottom: 30, left: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Here are some Features',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                )),
            // First button
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ASLRecognitionScreen(),
                  ),
                );
              },
              child: Container(
                width: 350,
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 124, 216, 201),
                  border: Border.all(
                    color: const Color.fromARGB(255, 225, 225, 225),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns text to the left
                  children: [
                    const Text(
                      "Sign to Predicted Text",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(
                        height:
                            5), // Space between the title and the description
                    const Text(
                      "Use this feature to translate sign language to text in real-time.",
                      style: TextStyle(
                        color: Colors
                            .black54, // A lighter color for the description
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Space between buttons

            const SizedBox(height: 10),
            // Second button
            GestureDetector(
              onTap: () {
                // Navigate to another screen or perform a different action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const TextToASLScreen(), // Change to the desired screen
                  ),
                );
              },
              child: Container(
                width: 350,
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 118, 201, 224),
                  border: Border.all(
                    color: const Color.fromARGB(255, 225, 225, 225),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns text to the left
                  children: [
                    const Text(
                      "Text to Sign Language",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(
                        height:
                            5), // Space between the title and the description
                    const Text(
                      "Use this feature to translate text to sign language in real-time.",
                      style: TextStyle(
                        color: Colors
                            .black54, // A lighter color for the description
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
