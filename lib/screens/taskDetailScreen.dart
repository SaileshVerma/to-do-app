import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/emptyScreenText.dart';

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
        iconTheme: IconThemeData(
          color: Colors.black54,
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
        title: Text(
          item.title,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              child: Text(
                item.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 50),
            Divider(
              height: 6,
              thickness: 1,
            ),
            Container(
              child: item.subTaskData.length == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: EmptyScreenText("Let's add here"),
                    )
                  : Expanded(
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
                                  color: Colors.black45,
                                  fontSize: 14,
                                  decoration: item.subTaskData[i].iscompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              trailing: IconButton(
                                color: item.subTaskData[i].iscompleted
                                    ? Colors.grey
                                    : Colors.black38,
                                icon: Icon(Icons.cancel_outlined),
                                onPressed: () {
                                  taskprovider.deleteSubTask(
                                      item.subTaskData[i].id, id);
                                },
                              ),
                              leading: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor: Colors.black38,
                                ),
                                child: Checkbox(
                                  activeColor: Colors.black26,
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
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddSubTask(
            itemId: id,
          ),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
