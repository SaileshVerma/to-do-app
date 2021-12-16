import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/taskProvider.dart';
import '../models/subtaskmodel.dart';
import '../widget/addSubTask.dart';

class TaskDetailScreen extends StatefulWidget {
  final String id;
  // final String title;
  // final String desc;
  // final List<SubTaskModel> subTaskData;
  // final void Function(String itemId, String title) addSubTask;
  // final void Function(String subitemId, String itemid) deleteSubTask;
  // final void Function(String subitemId, String itemId) changeSubStatus;
  TaskDetailScreen({
    //required this.subTaskData,
    // required this.addSubTask,
    // required this.deleteSubTask,
    // required this.changeSubStatus,
    // required this.title,
    // required this.desc,
    required this.id,
  });

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    final item =
        taskprovider.taskdata.firstWhere((element) => element.id == widget.id);

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
                              item.subTaskData[i].id, widget.id);

                          // widget.deleteSubTask(
                          //     widget.subTaskData[i].id, widget.id);
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
                                item.subTaskData[i].id, widget.id);
                            // widget.changeSubStatus(
                            //   widget.subTaskData[i].id,
                            //   widget.id,
                            // );
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
                  taskprovider.reorderable(widget.id, oldindex, newindex);
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
            itemId: widget.id,
            //    addSubTask: widget.addSubTask,
          ),
        ),
        tooltip: 'Add new note',
        child: Icon(Icons.add),
      ),
    );
  }
}
