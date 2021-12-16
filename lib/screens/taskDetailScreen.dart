import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/taskProvider.dart';

import '../widget/addSubTask.dart';

class TaskDetailScreen extends StatelessWidget {
  final String id;

  TaskDetailScreen({
    required this.id,
  });

  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    final item =
        taskprovider.taskdata.firstWhere((element) => element.id == id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[200],
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Text(
                item.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: ReorderableListView.builder(
                itemCount: item.subTaskData.length,
                itemBuilder: (ctx, i) => Column(
                  key: Key(
                    i.toString(),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        item.subTaskData[i].title,
                        style: TextStyle(
                          decoration: item.subTaskData[i].iscompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        color: item.subTaskData[i].iscompleted
                            ? Colors.grey
                            : Colors.blueAccent[200],
                        icon: Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          taskprovider.deleteSubTask(
                              item.subTaskData[i].id, id);
                        },
                      ),
                      leading: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Colors.blueAccent[200],
                        ),
                        child: Checkbox(
                          activeColor: Colors.grey,
                          value: item.subTaskData[i].iscompleted,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onChanged: (val) {
                            taskprovider.changeSubStatus(
                                item.subTaskData[i].id, id);
                          },
                        ),
                      ),
                    ),
                    Divider(
                      height: 6,
                      thickness: 1,
                    ),
                  ],
                ),
                onReorder: (oldindex, newindex) {
                  taskprovider.reorderable(id, oldindex, newindex);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent[200],
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddSubTask(
            itemId: id,
          ),
        ),
        tooltip: 'Add new note',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
