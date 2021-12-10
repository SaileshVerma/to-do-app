import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddSubTask extends StatelessWidget {
  Function(String title) addSubTask;
  AddSubTask({required this.addSubTask});

  String title = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
            onPressed: () {
              addSubTask(title);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("task added successfully")));
              Navigator.pop(context);
            },
            child: const Text("DONE"))
      ],
      title: const Text("Add Something!"),
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
                title = val;
              },
            ),
          ],
        ),
      ),
    );
  }
}
