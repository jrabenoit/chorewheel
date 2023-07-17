import 'package:flutter/foundation.dart';
import 'dart:math';

enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

extension RotateList<E> on List<E> {
  List<E> rotate(int count) {
    var result = List<E>.from(this);
    count %= length;
    if (count > 0) count -= length;
    var moved = result.getRange(0, count.abs()).toList();
    result.removeRange(0, count.abs());
    result.addAll(moved);
    return result;
  }
}

class Chore {
  String name;
  bool done;

  Chore({required this.name, this.done = false});
}

class Member {
  String name;

  Member({required this.name});
}

class ScheduleDay {
  DateTime date;
  String type;
  Map<Member, Chore>? assignments;

  ScheduleDay({required this.date, required this.type, this.assignments});
}

class Schedule {
  List<ScheduleDay> days;

  Schedule({required this.days});
}

class ScheduleProvider with ChangeNotifier {
  Schedule? schedule;
  List<Member> members = [Member(name: 'James'), Member(name: 'Kat')];
  List<Chore> chores = [
    Chore(name: 'Laundry'),
    Chore(name: 'Dishes'),
    Chore(name: 'Cooking'),
    Chore(name: 'Vacuuming'),
    Chore(name: 'Dusting'),
    Chore(name: 'Bathroom Cleaning'),
    Chore(name: 'Mopping'),
    Chore(name: 'Trash'),
    Chore(name: 'Grocery Shopping'),
    Chore(name: 'Lawn Mowing')
  ];
  Weekday dateNight = Weekday.friday;
  List<String> lastSchedulePattern = [];

  ScheduleProvider() {
    generateSchedule();
  }

  void addDate(Weekday day) {
    dateNight = day;
    notifyListeners();
  }

  void addMember(String name) {
    members.add(Member(name: name));
    notifyListeners();
  }

  void removeMember(Member member) {
    members.remove(member);
    notifyListeners();
  }

  void addChore(String name) {
    chores.add(Chore(name: name));
    notifyListeners();
  }

  void removeChore(Chore chore) {
    chores.remove(chore);
    notifyListeners();
  }

  void generateSchedule() {
    print('Generating schedule...');

    List<String> scheduleTemplate = ['Rest', 'Chore', 'Chore', 'Rest', 'Chore', 'Chore', 'Rest'];
    int rotationAmount = lastSchedulePattern.isEmpty ? 0 : (scheduleTemplate.indexOf(lastSchedulePattern[0]) + 1) % 7;
    List<String> newSchedulePattern = List.from(scheduleTemplate)..rotate(rotationAmount);

    // Replace one 'Rest' day with 'Date' on the selected date night.
    newSchedulePattern[dateNight.index] = 'Date';

    print('New schedule pattern: $newSchedulePattern');

    List<ScheduleDay> days = [];
    DateTime today = DateTime.now();

    // Reset the 'done' status of all chores
    for (Chore chore in chores) {
      chore.done = false;
    }

    for (int i = 0; i < 7; i++) {
      DateTime date = today.add(Duration(days: i));
      String type = newSchedulePattern[i];
      Map<Member, Chore>? assignments;

      if (type == 'Chore') {
        assignments = {};
        for (Member member in members) {
          // Find a chore that hasn't been done yet
          Chore? chore = chores.firstWhere((chore) => !chore.done, orElse: () => chores.first);
          assignments[member] = chore!;
          chore.done = true;
        }
      }

      days.add(ScheduleDay(date: date, type: type, assignments: assignments));
    }

    schedule = Schedule(days: days);
    lastSchedulePattern = newSchedulePattern;

    print('Schedule generated: $schedule');
    notifyListeners();
  }

  void toggleChoreDone(Member member, Chore chore) {
    chore.done = !chore.done;
    notifyListeners();
  }
}
