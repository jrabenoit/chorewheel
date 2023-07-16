import 'package:flutter/material.dart';

class ChoreWheel extends StatefulWidget {
  final GlobalKey<ChoreWheelState> choreWheelKey;

  ChoreWheel({Key? key, required this.choreWheelKey}) : super(key: key);

  @override
  ChoreWheelState createState() => ChoreWheelState();
}

class ChoreWheelState extends State<ChoreWheel> {
  static const List<String> daysOfWeek = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  static const String dateDay = 'Friday';
  static const int maxChoreDaysInRow = 2;

  Map<String, String> schedule = {};
  List<String> chores = [
    'dishes', 'laundry', 'cutting grass', 'vacuuming', 'dusting', 'sweeping',
    'cleaning bathroom', 'grocery shopping', 'cooking', 'gardening',
    'taking out trash', 'cleaning windows', 'making bed', 'ironing clothes',
    'feeding pets', 'washing car'
  ];
  List<String> members = ['James', 'Kat'];

  @override
  void initState() {
    super.initState();
    initializeSchedule();
  }

  void initializeSchedule() {
    schedule.clear();
    var lastChoreDays = 0;
    var restDays = 2;
    var availableChores = List<String>.from(chores); // Make a copy of the chores
    availableChores.shuffle(); // To ensure variety
    List<String> tempDays = List.from(daysOfWeek)..remove(dateDay)..shuffle(); // Remove date day and shuffle others

    schedule[dateDay] = 'Date Day'; // Initialize date day

    tempDays.forEach((day) {
      if (restDays > 0 && lastChoreDays == maxChoreDaysInRow) {
        // If the maximum number of consecutive chore days is reached, the next day is a rest day
        schedule[day] = 'Rest Day';
        restDays--;
        lastChoreDays = 0;
      } else if (restDays > 0 && lastChoreDays < maxChoreDaysInRow && tempDays.indexOf(day) > tempDays.length - restDays - 1) {
        // If we don't have enough days left to fit all rest days without breaking the maximum consecutive chore days rule, the next day is a rest day
        schedule[day] = 'Rest Day';
        restDays--;
        lastChoreDays = 0;
      } else {
        // If no chores left, repeat from the beginning
        if (availableChores.isEmpty) {
          availableChores = List<String>.from(chores);
          availableChores.shuffle();
        }

        var chore1 = availableChores.removeLast();
        var chore2 = availableChores.isEmpty ? '' : availableChores.removeLast();
        schedule[day] = '${members[0]} - $chore1, ${members[1]} - $chore2';
        lastChoreDays++;
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${daysOfWeek[index]}: ${schedule[daysOfWeek[index]]}'),
        );
      },
    );
  }
}
