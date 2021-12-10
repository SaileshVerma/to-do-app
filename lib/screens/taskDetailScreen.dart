import 'package:flutter/material.dart';
import '../models/subtaskmodel.dart';
import '../widget/addSubTask.dart';

// ignore: must_be_immutable
class TaskDetailScreen extends StatefulWidget {
  late String title;
  late String desc;
  List<SubTaskModel> subTaskData;
  //Function(SubTaskModel) getAddedSubTaskvalue;

  TaskDetailScreen(
      {required this.subTaskData,
      //  required this.getAddedSubTaskvalue,
      required this.title,
      required this.desc});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    void addSubTask(String title) {
      final item = SubTaskModel(
        id: DateTime.now().toString(),
        title: title,
      );

      setState(() {
        widget.subTaskData.add(item);
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[200],
        title: Text(
          widget.title,
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
                widget.desc,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
              child: ReorderableListView.builder(
                itemCount: widget.subTaskData.length,
                itemBuilder: (ctx, i) => Column(
                  key: Key(i.toString()),
                  children: [
                    ListTile(
                      title: Text(
                        widget.subTaskData[i].title,
                        style: TextStyle(
                            decoration: widget.subTaskData[i].iscompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      trailing: IconButton(
                        color: widget.subTaskData[i].iscompleted
                            ? Colors.grey
                            : Colors.blueAccent[200],
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            widget.subTaskData.removeWhere((element) =>
                                element.id == widget.subTaskData[i].id);
                          });
                        },
                      ),
                      leading: Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.blueAccent[200]),
                        child: Checkbox(
                          activeColor: Colors.grey,
                          value: widget.subTaskData[i].iscompleted,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onChanged: (val) {
                            setState(() {
                              widget.subTaskData[i].iscompleted = val!;
                            });
                          },
                        ),
                      ),
                    ),
                    Divider(height: 6, thickness: 1),
                  ],
                ),
                onReorder: (oldindex, newindex) {
                  setState(() {
                    if (oldindex < newindex) {
                      newindex = newindex - 1;
                    }

                    final item = (widget.subTaskData).removeAt(oldindex);
                    widget.subTaskData.insert(newindex, item);
                  });
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
            addSubTask: addSubTask,
          ),
        ),
        tooltip: 'Add new note',
        child: Icon(Icons.add),
      ),
    );
  }
}
