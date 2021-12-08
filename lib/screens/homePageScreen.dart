import 'package:flutter/material.dart';
import 'package:todo/models/subtaskmodel.dart';
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
    TaskModel(false, "1", "Meeting",
        "attend a meeting at 3 PM todayMtend a meeting at 3 PM", [
      SubTaskModel("1", "title", false),
      SubTaskModel("2", "title", false),
      SubTaskModel("3", "title", false),
      SubTaskModel("4", "title", false),
      SubTaskModel("5", "title", false),
    ]),
    TaskModel(false, "2", "Assignment",
        "complete all the pending assignment of lab practical", []),
    TaskModel(false, "3", "Maths Assignment",
        "submit the maths assignemnt to your teacher", []),
    TaskModel(false, "4", "Call ur friend",
        "tell ur friend about the work assign by the teacher", []),
  ];

  @override
  Widget build(BuildContext context) {
    void addTask() {
      showDialog(
        context: context,
        builder: (context) => Container(child: AddTaskBox(
          getaddedvalues: (i) {
            setState(() {
              TaskModel obj = new TaskModel(
                  i.isActive, i.id, i.title, i.description, i.subTaskData);
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
          elevation: 0,
          bottom: TabBar(
            indicatorWeight: 1,
            labelColor: Colors.blueAccent[200],
            unselectedLabelColor: Colors.white70,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white,
            ),
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  "ALL",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Tab(
                child: Text(
                  "ACTIVE",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Tab(
                child: Text(
                  "COMPLETED",
                  style: TextStyle(fontSize: 15),
                ),
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
            CompletedTaskList(
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
                completeList:
                    data.where((element) => element.isActive == true).toList())
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
        child: data.isEmpty
            ? Center(
                child: Container(
                  child: Text(
                    "Lets Do Something",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : Column(
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
                              // getAddedSubTask: (val) {
                              //   setState(() {
                              //     data[i].subTaskData.add(val);
                              //   });
                              // },
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
                                    data[data.indexWhere(
                                            (e) => e.title == v.title)]
                                        .description = v.description;
                                  });
                                }
                              },
                              id: data[i].id,
                              isAcitve: data[i].isActive,
                              title: data[i].title,
                              desc: data[i].description,
                              subTaskData: data[i].subTaskData,
                            )),
                  ),
                ],
              ),
      ),
    );
  }
}
