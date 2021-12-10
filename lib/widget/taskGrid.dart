import 'package:flutter/material.dart';
import '../models/subtaskmodel.dart';
import '../models/taskmodel.dart';

import '../screens/taskDetailScreen.dart';

import '../widget/editTaskbox.dart';

// ignore: must_be_immutable
class TaskGrid extends StatefulWidget {
  Function(TaskModel) setId;
  Function(String) setDeletedTitle;
  Function(TaskModel) setEditedTask;
  //Function(SubTaskModel) getAddedSubTask;
  late String id;
  late bool isAcitve;
  late String title;
  late String desc;
  late List<SubTaskModel> subTaskData;
  TaskGrid({
    required this.setId,
    required this.title,
    required this.desc,
    required this.id,
    required this.isAcitve,
    required this.subTaskData,
    required this.setDeletedTitle,
    required this.setEditedTask,
    // required this.getAddedSubTask,
  });

  @override
  _TaskGridState createState() => _TaskGridState();
}

class _TaskGridState extends State<TaskGrid> {
  TaskModel obj = TaskModel(
      id: (DateTime.now()).toString(),
      title: "",
      description: "",
      subTaskData: []);
  @override
  void initState() {
    obj.id = widget.id;
    obj.isActive = widget.isAcitve;
    obj.title = widget.title;
    obj.description = widget.desc;

    super.initState();
  }

  void editTask() {
    showDialog(
      context: context,
      builder: (context) => Container(
        child: EditTaskBox(
          receivedId: widget.id,
          datalist: widget.subTaskData,
          isActive: widget.isAcitve,
          receviedTitle: widget.title,
          receviedDesc: widget.desc,
          setEditedvalues: (i) {
            setState(() {
              obj.description = i.description;
              obj.title = i.title;
              widget.setEditedTask(obj);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          // navigating to task's subtask screen
          builder: (ctx) => TaskDetailScreen(
              // getAddedSubTaskvalue: (val) {
              //   setState(() {
              //     widget.getAddedSubTask(val);
              //   });
              // },
              subTaskData: widget.subTaskData,
              title: widget.title,
              desc: widget.desc))),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.isAcitve ? Colors.grey : Colors.blue,
                Colors.blueGrey
              ],
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              widget.title,
              style: TextStyle(
                  decoration: widget.isAcitve
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.desc.length > 35
                    ? hidetext(widget.desc) + "........"
                    : widget.desc,
                style: TextStyle(
                    decoration: widget.isAcitve
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
                    value: obj.isActive,
                    onChanged: (val) {
                      setState(() {
                        obj.isActive = val!;
                      });
                      widget.setId(obj);
                    }),
                const SizedBox(
                  width: 22,
                ),
                IconButton(
                  onPressed: () {
                    widget.setDeletedTitle(widget.title);
                    Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text("Item deleted Successfully")));
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.setEditedTask(obj);
                    editTask();
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
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
