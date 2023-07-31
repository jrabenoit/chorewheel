import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chorewheel/models/schedule.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChoreWheel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(child: ScheduleView()),
            AddDateButton(),
            AddMemberButton(),
            AddChoreButton(),
            GenerateScheduleButton(),
            CurrentMembersView(),
            CurrentDateNightView(),
            CurrentChoresView(),
          ],
        ),
      ),
    );
  }
}



class CurrentMembersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, scheduleProvider, child) {
        return Wrap(
          children: scheduleProvider.members
              .map((member) => Chip(label: Text(member.name)))
              .toList(),
        );
      },
    );
  }
}

class CurrentChoresView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, scheduleProvider, child) {
        return Wrap(
          children: scheduleProvider.chores.map((chore) {
            return Chip(
              label: Text(chore.name),
              deleteIcon: Icon(Icons.close),
              onDeleted: () {
                scheduleProvider.removeChore(chore);
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class CurrentDateNightView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, scheduleProvider, child) {
        return Chip(
          backgroundColor: Theme.of(context).primaryColor,
          label: Text('Date night: ${scheduleProvider.dateNight}',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}



class AddDateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text('Add Date'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text('Add Date'),
              children: <Widget>[
                for (var day in Weekday.values)
                  SimpleDialogOption(
                    child: Text(day.toString().split('.').last),
                    onPressed: () {
                      Provider.of<ScheduleProvider>(context, listen: false).addDate(day);
                      Navigator.pop(context);
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }
}



class ScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, scheduleProvider, child) {
        return ListView.builder(
          itemCount: scheduleProvider.schedule?.days.length ?? 0,
          itemBuilder: (context, index) {
            ScheduleDay day = scheduleProvider.schedule!.days[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text('${DateFormat('MMMM d - EEEE - ').format(day.date)}${day.type} Day'),
                subtitle: Wrap(
                  children: day.assignments?.entries.map((entry) => Chip(
                    label: Text('${entry.key.name} - ${entry.value.name}'),
                    backgroundColor: entry.value.done ? Colors.green : null,
                  )).toList() ?? [],
                ),
              ),
            );
          },
        );
      },
    );
  }
}


class AddMemberButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text('Add Member'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text('Add Member'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (value) {
                      Provider.of<ScheduleProvider>(context, listen: false).addMember(value);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class AddChoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text('Add Chore'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text('Add Chore'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (value) {
                      Provider.of<ScheduleProvider>(context, listen: false).addChore(value);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class GenerateScheduleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text('Generate Schedule'),
      onPressed: () {
        Provider.of<ScheduleProvider>(context, listen: false).generateSchedule();
      },
    );
  }
}
