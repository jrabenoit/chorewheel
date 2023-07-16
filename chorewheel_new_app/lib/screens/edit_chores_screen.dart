import 'package:flutter/material.dart';

class EditChoresScreen extends StatefulWidget {
  final List<String> chores;

  EditChoresScreen({required this.chores});

  @override
  _EditChoresScreenState createState() => _EditChoresScreenState();
}

class _EditChoresScreenState extends State<EditChoresScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Chores'),
      ),
      body: ListView.builder(
        itemCount: widget.chores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.chores[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.chores.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Chore'),
                content: TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: 'Enter chore name'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      setState(() {
                        widget.chores.add(_textController.text);
                        _textController.clear();
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
