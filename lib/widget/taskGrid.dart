import 'package:flutter/material.dart';
import 'package:todo/data/dummyData.dart';

import 'package:todo/taskDetailScreen.dart';

// ignore: must_be_immutable
class TaskGrid extends StatefulWidget {
  Function(String) getDeletedTitle;
  late String title;
  late String desc;
  TaskGrid(
      {required this.title, required this.desc, required this.getDeletedTitle});

  @override
  _TaskGridState createState() => _TaskGridState();
}

class _TaskGridState extends State<TaskGrid> {
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
                widget.desc.length > 30
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
                    onPressed: () {},
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
  for (int i = 0; i < 30; i++) {
    temp = temp + msg[i];
  }
  return temp;
}

void deleteItem(String title) {
  data.removeWhere((element) => element.title == title);
}
