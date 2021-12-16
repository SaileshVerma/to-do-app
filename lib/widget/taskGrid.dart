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
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    item.isActive ? Colors.grey.shade300 : Colors.white10,
                    Colors.blueGrey.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: item.isActive,
                    onChanged: (val) {
                      taskprovider.changeStatus(id);
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 30, right: 20, top: 20),
                    child: Container(
                      width: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              decoration: item.isActive
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            item.description.length > 25
                                ? hidetext(item.description) + "..."
                                : item.description,
                            style: TextStyle(
                              decoration: item.isActive
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: Colors.black45,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //  SizedBox(width: 30),
                  Row(
                    children: [
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
                          Icons.delete_outline,
                          color: Colors.black38,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black38,
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
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
