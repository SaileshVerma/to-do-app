import 'package:flutter/material.dart';
import 'package:todo/models/subtaskmodel.dart';
import 'package:todo/widget/addSubTask.dart';

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
  // List<SubTaskModel> subData = [
  //   SubTaskModel("1", "title", false),
  //   SubTaskModel("2", "title", false),
  //   SubTaskModel("3", "title", false),
  //   SubTaskModel("4", "title", false),
  //   SubTaskModel("5", "title", false),
  // ];

  @override
  Widget build(BuildContext context) {
    void addSubTask() {
      showDialog(
          context: context,
          builder: (context) => AddSubTask(getaddedsubtask: (val) {
                setState(() {
                  widget.subTaskData.add(val);
                  // widget.getAddedSubTaskvalue(val);
                });
              }));
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
        padding: const EdgeInsets.all(8.0),
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
            Expanded(
              child: ListView.builder(
                itemCount: widget.subTaskData.length,
                itemBuilder: (ctx, i) => ListTile(
                    title: Text(widget.subTaskData[i].title),
                    leading: Theme(
                      data: ThemeData(
                          unselectedWidgetColor: Colors.blueAccent[200]),
                      child: Checkbox(
                        value: widget.subTaskData[i].iscompleted,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onChanged: (val) {
                          setState(() {
                            widget.subTaskData[i].iscompleted = val!;
                            if (widget.subTaskData[i].iscompleted == true) {
                              widget.subTaskData.removeWhere((element) =>
                                  element.id == widget.subTaskData[i].id);
                            }
                          });
                        },
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent[200],
        onPressed: () => addSubTask(),
        tooltip: 'Add new note',
        child: Icon(Icons.add),
      ),
    );
  }
}
