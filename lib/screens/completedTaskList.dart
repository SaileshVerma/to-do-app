import 'package:flutter/material.dart';
import 'package:todo/models/taskmodel.dart';

// ignore: must_be_immutable
class CompletedTaskList extends StatefulWidget {
  late List<TaskModel> completeList;

  @override
  _CompletedTaskListState createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ad"),
    );
  }
}
