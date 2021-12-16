import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/taskProvider.dart';

class AddSubTask extends StatelessWidget {
  final String itemId;

  AddSubTask({
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);

    String title = "";
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      actions: [
        TextButton(
          onPressed: () {
            taskprovider.addSubTask(itemId, title);

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
