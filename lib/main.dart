import 'package:flutter/material.dart';
import 'package:peach_leaf_detection_app/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leaf Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Typography.blackMountainView
      ),
      home: const Homepage(),
    );
  }
}
