import 'package:flutter/material.dart';
import 'package:todo/screens/activeTaskList.dart';
import 'package:todo/screens/completedTaskList.dart';
import 'package:todo/widget/addTaskbox.dart';
import 'package:todo/widget/taskGrid.dart';

import '../models/taskmodel.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TaskModel> data = [
    TaskModel(false, "1", "Meeting", "attend a meeting at 3 PM today "),
    TaskModel(false, "2", "Assignment",
        "complete all the pending assignment of lab practical"),
    TaskModel(false, "3", "Maths Assignment",
        "submit the maths assignemnt to your teacher"),
    TaskModel(false, "4", "Call ur friend",
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
              TaskModel obj =
                  new TaskModel(i.isActive, i.id, i.title, i.description);
              data.add(obj);
            });
          },
        )),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text("All"),
              ),
              Tab(
                child: Text("Active"),
              ),
              Tab(
                child: Text("Completed"),
              ),
            ],
          ),
          backgroundColor: Colors.blueAccent[200],
          title: Text(
            "To-Do",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        body: TabBarView(
          children: [
            allTaskList(data),
            ActiveTaskList(
                getId: (value) {
                  setState(() {
                    data[data.indexWhere((element) => element.id == value.id)]
                        .isActive = value.isActive;
                    print(value.isActive);
                  });
                },
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
                activeData: data
                    .where((element) => element.isActive == false)
                    .toList()),
            CompletedTaskList()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent[200],
          onPressed: () => addTask(),
          tooltip: 'Add new note',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget allTaskList(List<TaskModel> data) {
    return Container(
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
                      getId: (value) {
                        setState(() {
                          data[data.indexWhere(
                                  (element) => element.id == value.id)]
                              .isActive = value.isActive;
                        });
                      },
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
                      id: data[i].id,
                      isAcitve: data[i].isActive,
                      title: data[i].title,
                      desc: data[i].description)),
            ),
          ],
        ),
      ),
    );
  }
}
