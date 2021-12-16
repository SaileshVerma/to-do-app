import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helperFunctions/hideText.dart';
import '../providers/taskProvider.dart';

import '../screens/taskDetailScreen.dart';

import 'addEditTaskbox.dart';

class TaskGrid extends StatelessWidget {
  final String id;

  TaskGrid({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    final item =
        taskprovider.taskdata.firstWhere((element) => element.id == id);
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          // navigating to task's subtask screen
          builder: (ctx) => TaskDetailScreen(
            id: id,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              item.isActive ? Colors.grey : Colors.blue,
              Colors.blueGrey,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              item.title,
              style: TextStyle(
                decoration: item.isActive
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.description.length > 35
                    ? hidetext(item.description) + "........"
                    : item.description,
                style: TextStyle(
                  decoration: item.isActive
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: Colors.white,
                  fontSize: 12,
                ),
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                  value: item.isActive,
                  onChanged: (val) {
                    taskprovider.changeStatus(id);
                  },
                ),
                const SizedBox(width: 22),
                IconButton(
                  onPressed: () {
                    taskprovider.deleteTask(id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content: const Text("task deleted successfully"),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Container(
                        child: AddEditTaskBox(
                          receivedTitle: item.title,
                          receivedDesc: item.description,
                          addeditDescription: (title, desc) {
                            taskprovider.editTask(item.id, title, desc);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
