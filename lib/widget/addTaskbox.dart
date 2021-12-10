import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddTaskBox extends StatelessWidget {
  Function(String title, String desc) addTask;
  AddTaskBox({required this.addTask});

  String title = "";
  String desc = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
            onPressed: () {
              addTask(title, desc);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: const Text("task added successfully"),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text("OK"))
      ],
      title: const Text("Lets Add Today Work : )"),
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
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 6,
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
