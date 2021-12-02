import 'package:flutter/material.dart';
import 'package:todo/taskDetailScreen.dart';

// ignore: must_be_immutable
class TaskGrid extends StatelessWidget {
  late String title;
  late String desc;
  TaskGrid(this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => TaskDetailScreen(title: title, desc: desc))),
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
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                desc.length > 30 ? hidetext(desc) + "....." : desc,
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String hidetext(String msg) {
  String temp = "";
  for (int i = 0; i < 30; i++) {
    temp = temp + msg[i];
  }
  return temp;
}
