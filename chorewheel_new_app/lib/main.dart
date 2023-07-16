import 'package:flutter/material.dart';
import 'package:chorewheel_new_app/screens/home_screen.dart';

void main() {
  runApp(ChoreWheelApp());
}

class ChoreWheelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChoreWheel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
