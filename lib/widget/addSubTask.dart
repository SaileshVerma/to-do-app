import 'package:flutter/material.dart';
import 'package:todo/models/subtaskmodel.dart';

// ignore: must_be_immutable
class AddSubTask extends StatefulWidget {
  Function(SubTaskModel) getaddedsubtask;
  AddSubTask({required this.getaddedsubtask});

  @override
  _AddSubTaskState createState() => _AddSubTaskState();
}

class _AddSubTaskState extends State<AddSubTask> {
  SubTaskModel obj = SubTaskModel(DateTime.now().toString(), "", false);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
            onPressed: () {
              widget.getaddedsubtask(obj);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("task added successfully")));
              Navigator.pop(context);
            },
            child: Text("DONE"))
      ],
      title: Text("Add Something!"),
      content: Container(
        height: 50,
        child: Column(
          children: [
            TextField(
              //controller: con,

              decoration: InputDecoration(
                hintText: "Task Title",
              ),
              onChanged: (val) {
                obj.title = val;
              },
            ),
          ],
        ),
      ),
    );
  }
}
