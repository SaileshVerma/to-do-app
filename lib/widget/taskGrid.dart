import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widget/softButton.dart';

import '../helperFunctions/hideText.dart';
import '../providers/taskProvider.dart';

import '../screens/taskDetailScreen.dart';

import 'addEditTaskbox.dart';

class TaskGrid extends StatelessWidget {
  final String id;
  final int index;

  final Animation<double> animation;
  final Function(String id, int index) deleteItem;

  TaskGrid({
    required this.id,
    required this.index,
    required this.animation,
    required this.deleteItem,
  });

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    final item =
        taskprovider.taskdata.firstWhere((element) => element.id == id);
    return SizeTransition(
      sizeFactor: animation,
      child: InkWell(
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
              elevation: 7,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      item.isActive ? Colors.white30 : Colors.grey.shade300,
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
                      padding: const EdgeInsets.only(
                        bottom: 60,
                        top: 30,
                      ),
                      child: Container(
                        width: 145,
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
                              item.description.length > 24
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
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: Row(
                        children: [
                          SoftButton(
                            color: Colors.grey.shade300,
                            func: () {
                              //delete task
                              //   taskprovider.deleteTask(id);
                              deleteItem(id, index);
                              //   print("runn ?>>>>>>>>>>");
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     duration: Duration(seconds: 1),
                              //     content:
                              //         const Text("task deleted successfully"),
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.black38,
                            ),
                          ),
                          SoftButton(
                            color: Colors.grey.shade300,
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black38,
                            ),
                            func: () {
                              showDialog(
                                context: context,
                                builder: (context) => Container(
                                  child: AddEditTaskBox(
                                    receivedTitle: item.title,
                                    receivedDesc: item.description,
                                    addeditDescription: (title, desc) {
                                      taskprovider.editTask(
                                          item.id, title, desc);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
