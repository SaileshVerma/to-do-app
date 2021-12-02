import 'package:flutter/material.dart';
import 'package:todo/data/dummyData.dart';

import 'package:todo/taskDetailScreen.dart';

// ignore: must_be_immutable
class TaskGrid extends StatefulWidget {
  late String title;
  late String desc;
  TaskGrid(this.title, this.desc);

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
            color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
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
                    ? hidetext(widget.desc) + "....."
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
                      setState(() {
                        deleteItem(widget.title);
                      });
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
