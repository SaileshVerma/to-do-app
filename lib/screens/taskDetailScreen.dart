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
        backgroundColor: Colors.blueAccent[200],
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            child: Text(
              desc,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
