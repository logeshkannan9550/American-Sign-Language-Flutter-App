// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'home.dart'; // Make sure home.dart is correctly set up for the next screen.

class Boarding extends StatefulWidget {
  const Boarding({super.key});

  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECEFE8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign",
                  style: TextStyle(
                    color: const Color.fromRGBO(6, 168, 168, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                Text(
                  "Connect",
                  style: TextStyle(
                    color: const Color.fromRGBO(240, 118, 30, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Update the image path to your actual asset path
            Image.asset(
                'assets/images/ASL_Waving_person.gif'), // Replace with your actual image
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  "Welcome!",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 155, 152, 152),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "The Real-Time Sign Language Detection",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 191, 191, 191),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
                GestureDetector(
                  onTap: () {
                    // Change MyApp() to the appropriate screen you want to navigate to
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // Wrap the Boarding widget in a MaterialApp
    title: 'ASL Detection App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Boarding(), // Set Boarding as the initial screen
  ));
}
