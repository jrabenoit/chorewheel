import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chorewheel/models/schedule.dart';
import 'package:chorewheel/screens/home_page.dart';

void main() {
  runApp(ChoreWheel());
}

class ChoreWheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScheduleProvider(),
      child: MaterialApp(
        title: 'Chore Wheel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
