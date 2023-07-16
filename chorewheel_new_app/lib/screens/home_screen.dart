import 'package:flutter/material.dart';
import 'package:chorewheel_new_app/screens/edit_chores_screen.dart';
import 'package:chorewheel_new_app/models/chore_wheel.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ChoreWheelState> _choreWheelKey = GlobalKey<ChoreWheelState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChoreWheel App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditChoresScreen(chores: _choreWheelKey.currentState?.chores ?? []),
                ),
              ).then((value) {
                if (value != null) {
                  _choreWheelKey.currentState?.chores = value;
                  _choreWheelKey.currentState?.initializeSchedule();
                }
              });
            },
          ),
        ],
      ),
      body: ChoreWheel(key: _choreWheelKey, choreWheelKey: _choreWheelKey), // Pass the same key to ChoreWheel widget
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _choreWheelKey.currentState?.initializeSchedule();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
