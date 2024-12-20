// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:asl_project_1/ASLRecognitionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Adjust the import if needed

void main() {
  testWidgets('ASL Hand Sign Recognition screen test',
      (WidgetTester tester) async {
    // Build the ASLRecognitionScreen and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: ASLRecognitionScreen()));

    // Check if the prediction text is initially empty.
    expect(find.text('Predicted Sign: '), findsOneWidget);

    // Check if the button to get the prediction exists.
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
