import 'package:flutter/material.dart';
import 'package:widgets_basic/screens/bottomnavbar_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavBar(), // Use the BottomNavBar widget as the home page
    );
  }
}
