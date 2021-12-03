import 'package:flutter/material.dart';
import 'package:todo/widget/addTaskbox.dart';
import 'package:todo/widget/taskGrid.dart';

import '../models/taskmodel.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TaskModel> data = [
    TaskModel("Meeting", "attend a meeting at 3 PM today "),
    TaskModel(
        "Assignment", "complete all the pending assignment of lab practical"),
    TaskModel(
        "Maths Assignment", "submit the maths assignemnt to your teacher"),
    TaskModel("Call ur friend",
        "tell ur friend about the work assign by the teacher"),
  ];

  @override
  Widget build(BuildContext context) {
    void addTask() {
      showDialog(
        context: context,
        builder: (context) => Container(child: AddTaskBox(
          getaddedvalues: (i) {
            setState(() {
              TaskModel obj = new TaskModel(i.title, i.description);
              data.add(obj);
            });
          },
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[200],
        title: Text(
          "To-Do",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 11,
                    ),
                    itemBuilder: (ctx, i) => TaskGrid(
                        getDeletedTitle: (val) {
                          setState(() {
                            data.removeWhere((e) => e.title == val);
                          });
                        },
                        getEditedTask: (v) {
                          if (v.title.isNotEmpty) {
                            setState(() {
                              data[data.indexWhere((e) => e.title == v.title)]
                                  .description = v.description;
                            });
                          }
                        },
                        title: data[i].title,
                        desc: data[i].description)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent[200],
        onPressed: () => addTask(),
        tooltip: 'Add new note',
        child: Icon(Icons.add),
      ),
    );
  }
}
