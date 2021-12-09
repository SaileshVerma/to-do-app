import 'package:flutter/material.dart';

import '../models/subtaskmodel.dart';
import '../models/taskmodel.dart';
import '../widget/addTaskbox.dart';

import '../screens/taskListScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TaskModel> data = [
    TaskModel(
      id: "1",
      title: "Meeting",
      description: "attend a meeting at 3 PM todayMtend a meeting at 3 PM",
      subTaskData: [
        SubTaskModel(id: "1", title: "meeting 1"),
        SubTaskModel(id: "2", title: "meeting 2"),
        SubTaskModel(id: "3", title: "meeting 3"),
        SubTaskModel(id: "4", title: "meeting 4"),
        SubTaskModel(id: "5", title: "meeting 5"),
      ],
    ),
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

  void changeStatus(TaskModel obj) {
    setState(() {
      data[data.indexWhere((element) => element.id == obj.id)].isActive =
          obj.isActive;
    });
  }

  void deleteTask(String title) {
    setState(() {
      data.removeWhere((e) => e.title == title);
    });
  }

  void editDescription(TaskModel obj) {
    setState(() {
      data[data.indexWhere((e) => e.title == obj.title)].description =
          obj.description;
    });
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) => Container(child: AddTaskBox(
        setaddedvalues: (i) {
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
            TaskListScreen(
              emptyDisplayText: "Lets Do Something",
              setId: changeStatus,
              setDeletedTitle: deleteTask,
              setEditedTask: editDescription,
              taskDataList: data, //complete task list
            ),
            TaskListScreen(
              emptyDisplayText: "No Active Task!!",
              setId: changeStatus,
              setDeletedTitle: deleteTask,
              setEditedTask: editDescription,
              taskDataList: // contains active data list
                  data.where((element) => element.isActive == false).toList(),
            ),
            TaskListScreen(
              emptyDisplayText: "No Task Completed Yet Hurry Up!!",
              setId: changeStatus,
              setDeletedTitle: deleteTask,
              setEditedTask: editDescription,
              taskDataList: //contains completed data list
                  data.where((element) => element.isActive == true).toList(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent[200],
          onPressed: addTask,
          tooltip: 'Add new note',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
