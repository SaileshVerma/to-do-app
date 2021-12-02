import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskDetailScreen extends StatelessWidget {
  late String title;
  late String desc;
  TaskDetailScreen({required this.title, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Container(
            child: Text(desc),
          ),
        ),
      ),
    );
  }
}
