import 'package:flutter/material.dart';

import 'package:todo/models/taskmodel.dart';

// ignore: must_be_immutable
class AddTaskBox extends StatefulWidget {
  Function(TaskModel) getaddedvalues;
  AddTaskBox({required this.getaddedvalues});

  @override
  _AddTaskBoxState createState() => _AddTaskBoxState();
}

class _AddTaskBoxState extends State<AddTaskBox> {
  TaskModel obj = new TaskModel("", "");
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
            onPressed: () {
              widget.getaddedvalues(obj);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("task added successfully")));
              Navigator.pop(context);
            },
            child: Text("OK"))
      ],
      title: Text("Lets Add Today Work : )"),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "title"),
              onChanged: (val) {
                obj.title = val;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "description"),
              onChanged: (val) {
                obj.description = val;
              },
            ),
          ],
        ),
      ),
    );
  }
}
