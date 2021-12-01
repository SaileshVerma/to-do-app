import 'package:flutter/material.dart';
import 'package:todo/data/dummyData.dart';
import 'package:todo/models/taskmodel.dart';

class AddTaskBox extends StatefulWidget {
  @override
  _AddTaskBoxState createState() => _AddTaskBoxState();
}

class _AddTaskBoxState extends State<AddTaskBox> {
  String title = "";
  String desc = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
            onPressed: () {
              data.add(TaskModel(title, desc));
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
                title = val;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "description"),
              onChanged: (val) {
                desc = val;
              },
            ),
          ],
        ),
      ),
    );
  }
}
