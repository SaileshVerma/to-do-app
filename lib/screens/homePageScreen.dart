import 'package:flutter/material.dart';
import 'package:todo/models/subtaskmodel.dart';
import 'package:todo/screens/activeTaskList.dart';
import 'package:todo/screens/completedTaskList.dart';
import 'package:todo/widget/addTaskbox.dart';
import 'package:todo/widget/emptyScreenText.dart';
import 'package:todo/widget/taskGrid.dart';

import '../models/taskmodel.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TaskModel> data = [
    TaskModel(
        isActive: false,
        id: "1",
        title: "Meeting",
        description: "attend a meeting at 3 PM todayMtend a meeting at 3 PM",
        subTaskData: [
          SubTaskModel(id: "1", title: "meeting 1", iscompleted: false),
          SubTaskModel(id: "2", title: "meeting 2", iscompleted: false),
          SubTaskModel(id: "3", title: "meeting 3", iscompleted: false),
          SubTaskModel(id: "4", title: "meeting 4", iscompleted: false),
          SubTaskModel(id: "5", title: "meeting 5", iscompleted: false),
        ]),
    TaskModel(
        isActive: false,
        id: "2",
        title: "Assignment",
        description: "complete all the pending assignment of lab practical",
        subTaskData: []),
    TaskModel(
        isActive: false,
        id: "3",
        title: "Maths Assignment",
        description: "submit the maths assignemnt to your teacher",
        subTaskData: []),
    TaskModel(
        isActive: false,
        id: "4",
        title: "Call ur friend",
        description: "tell ur friend about the work assign by the teacher",
        subTaskData: []),
  ];

  void changeStatus(value, data) {
    setState(() {
      data[data.indexWhere((element) => element.id == value.id)].isActive =
          value.isActive;
    });
  }

  void deleteTask(List<TaskModel> data, String val) {
    setState(() {
      data.removeWhere((e) => e.title == val);
    });
  }

  void editDescription(List<TaskModel> data, TaskModel v) {
    setState(() {
      data[data.indexWhere((e) => e.title == v.title)].description =
          v.description;
    });
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) => Container(child: AddTaskBox(
        getaddedvalues: (i) {
          setState(() {
            TaskModel obj = new TaskModel(
                isActive: i.isActive,
                id: i.id,
                title: i.title,
                description: i.description,
                subTaskData: i.subTaskData);
            data.add(obj);
          });
        },
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Tab(child: const Text("ALL", style: TextStyle(fontSize: 15))),
              Tab(child: const Text("ACTIVE", style: TextStyle(fontSize: 15))),
              Tab(
                  child:
                      const Text("COMPLETED", style: TextStyle(fontSize: 15)))
            ],
          ),
          backgroundColor: Colors.blueAccent[200],
          title: const Text(
            "To-Do",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        body: TabBarView(
          children: [
            allTaskList(data),
            ActiveTaskList(
                getId: (value) {
                  changeStatus(value, data);
                },
                getDeletedTitle: (val) {
                  deleteTask(data, val);
                },
                getEditedTask: (v) {
                  if (v.title.isNotEmpty) {
                    editDescription(data, v);
                  }
                },
                activeData: data
                    .where((element) => element.isActive == false)
                    .toList()),
            CompletedTaskList(
                getId: (value) {
                  changeStatus(value, data);
                },
                getDeletedTitle: (val) {
                  deleteTask(data, val);
                },
                getEditedTask: (v) {
                  if (v.title.isNotEmpty) {
                    editDescription(data, v);
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
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget allTaskList(List<TaskModel> data) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: data.isEmpty
            ? EmptyScreenText("Lets Do Something")
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
                                changeStatus(value, data);
                              },
                              getDeletedTitle: (val) {
                                deleteTask(data, val);
                              },
                              getEditedTask: (v) {
                                if (v.title.isNotEmpty) {
                                  editDescription(data, v);
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
