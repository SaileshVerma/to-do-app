import 'package:flutter/material.dart';
import '../models/subtaskmodel.dart';

import '../screens/taskDetailScreen.dart';

import 'addEditTaskbox.dart';

// ignore: must_be_immutable
class TaskGrid extends StatelessWidget {
  Function(String id) changeStatus;
  Function(String id) deleteTask;
  Function(String id, String title, String desc) editDescription;
  //Function(SubTaskModel) getAddedSubTask;
  late String id;
  late bool isAcitve;
  late String title;
  late String desc;
  late List<SubTaskModel> subTaskData;
  TaskGrid({
    required this.changeStatus,
    required this.title,
    required this.desc,
    required this.id,
    required this.isAcitve,
    required this.subTaskData,
    required this.deleteTask,
    required this.editDescription,
    // required this.getAddedSubTask,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          // navigating to task's subtask screen
          builder: (ctx) => TaskDetailScreen(
              subTaskData: subTaskData, title: title, desc: desc))),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [isAcitve ? Colors.grey : Colors.blue, Colors.blueGrey],
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                  decoration: isAcitve
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                desc.length > 35 ? hidetext(desc) + "........" : desc,
                style: TextStyle(
                    decoration: isAcitve
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: Colors.white,
                    fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                    checkColor: Colors.grey,
                    activeColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: isAcitve,
                    onChanged: (val) {
                      changeStatus(id);
                    }),
                const SizedBox(width: 22),
                IconButton(
                  onPressed: () {
                    deleteTask(id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content: const Text("task deleted successfully"),
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Container(
                        child: AddEditTaskBox(
                          receivedTitle: title,
                          receivedDesc: desc,
                          addeditDescription: (title, desc) {
                            editDescription(id, title, desc);
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// function to hide extra text in the grid
String hidetext(String msg) {
  String temp = "";
  for (int i = 0; i < 35; i++) {
    temp = temp + msg[i];
  }
  return temp;
}
