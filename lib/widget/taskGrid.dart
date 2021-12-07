import 'package:flutter/material.dart';
import 'package:todo/models/taskmodel.dart';

import 'package:todo/screens/taskDetailScreen.dart';

import 'editTaskbox.dart';

// ignore: must_be_immutable
class TaskGrid extends StatefulWidget {
  Function(TaskModel) getId;
  Function(String) getDeletedTitle;
  Function(TaskModel) getEditedTask;
  late String id;
  late bool isAcitve;
  late String title;
  late String desc;
  TaskGrid(
      {required this.getId,
      required this.title,
      required this.desc,
      required this.id,
      required this.isAcitve,
      required this.getDeletedTitle,
      required this.getEditedTask});

  @override
  _TaskGridState createState() => _TaskGridState();
}

class _TaskGridState extends State<TaskGrid> {
  TaskModel obj = TaskModel(true, (DateTime.now()).toString(), "", "");
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
        receviedTitle: widget.title,
        receviedDesc: widget.desc,
        getEditedvalues: (i) {
          setState(() {
            obj.description = i.description;
            obj.title = i.title;
            widget.getEditedTask(obj);
          });
        },
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) =>
              TaskDetailScreen(title: widget.title, desc: widget.desc))),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.blueGrey]),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.desc.length > 35
                    ? hidetext(widget.desc) + "........"
                    : widget.desc,
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                    checkColor: Colors.blue,
                    activeColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: obj.isActive,
                    onChanged: (val) {
                      setState(() {
                        obj.isActive = val!;
                      });
                      widget.getId(obj);
                    }),
                IconButton(
                    onPressed: () {
                      widget.getDeletedTitle(widget.title);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Item deleted Successfully")));
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      widget.getEditedTask(obj);
                      editTask();
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    )),
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
