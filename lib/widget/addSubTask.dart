import 'package:flutter/material.dart';

class AddSubTask extends StatelessWidget {
  final String itemId;
  final void Function(String itemid, String title) addSubTask;
  AddSubTask({
    required this.itemId,
    required this.addSubTask,
  });

  @override
  Widget build(BuildContext context) {
    String title = "";
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      actions: [
        TextButton(
          onPressed: () {
            addSubTask(itemId, title);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 1),
                content: Text("task added successfully"),
              ),
            );
            Navigator.pop(context);
          },
          child: const Text("DONE"),
        )
      ],
      title: const Text("Add Something!"),
      content: Container(
        height: 50,
        child: Column(
          children: [
            TextField(
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
