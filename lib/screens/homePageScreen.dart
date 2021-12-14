import 'package:flutter/material.dart';
import 'package:todo/widget/addEditTaskbox.dart';

import '../models/subtaskmodel.dart';
import '../models/taskmodel.dart';

import '../screens/taskListScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TaskModel> data = [
    TaskModel(
      id: "1",
      title: "Meeting",
      description: "attend a meeting at 3 PM todayMtend a meeting at 3 PM",
      subTaskData: [
        SubTaskModel(
          id: "1",
          title: "meeting 1",
        ),
        SubTaskModel(
          id: "2",
          title: "meeting 2",
        ),
        SubTaskModel(
          id: "3",
          title: "meeting 3",
        ),
        SubTaskModel(
          id: "4",
          title: "meeting 4",
        ),
        SubTaskModel(
          id: "5",
          title: "meeting 5",
        ),
      ],
    ),
    TaskModel(
      isActive: false,
      id: "2",
      title: "Assignment",
      description: "complete all the pending assignment of lab practical",
      subTaskData: [],
    ),
    TaskModel(
      isActive: false,
      id: "3",
      title: "Maths Assignment",
      description: "submit the maths assignemnt to your teacher",
      subTaskData: [],
    ),
    TaskModel(
      isActive: false,
      id: "4",
      title: "Call ur friend",
      description: "tell ur friend about the work assign by the teacher",
      subTaskData: [],
    ),
  ];

  void changeStatus(String id) {
    final item = data.firstWhere((element) => element.id == id);
    setState(() {
      item.toggleStatus();
    });
  }

  void deleteTask(String id) {
    setState(() {
      data.removeWhere((e) => e.id == id);
    });
  }

  void editTask(String id, String title, String desc) {
    final item = data.firstWhere((element) => element.id == id);

    setState(() {
      item.title = title;
      item.description = desc;
    });
  }

  void addTask(String title, String desc) {
    final item = TaskModel(
      id: DateTime.now().toString(),
      title: title,
      description: desc,
      subTaskData: [],
    );

    setState(() {
      data.add(item);
    });
  }

  void addSubTask(String itemId, String title) {
    final subItem = SubTaskModel(
      id: DateTime.now().toString(),
      title: title,
    );
    final item = data.firstWhere(
      (element) => element.id == itemId,
    );

    setState(() {
      item.subTaskData.add(subItem);
    });
  }

  void deleteSubTask(String subitemId, String itemId) {
    final item = data.firstWhere((element) => element.id == itemId);

    setState(() {
      item.subTaskData.removeWhere((e) => e.id == subitemId);
    });
  }

  void changeSubStatus(String subitemId, String itemId) {
    final item = data.firstWhere((element) => element.id == itemId);

    final subItem =
        item.subTaskData.firstWhere((element) => element.id == subitemId);

    setState(() {
      subItem.toggleSubStatus();
    });
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
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: const Text(
                  "ALL",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Tab(
                child: const Text(
                  "ACTIVE",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Tab(
                child: const Text(
                  "COMPLETED",
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          ),
          backgroundColor: Colors.blueAccent[200],
          title: const Text(
            "To-Do",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            TaskListScreen(
              addSubTask: addSubTask,
              changeSubStatus: changeSubStatus,
              deleteSubTask: deleteSubTask,
              emptyDisplayText: "Lets Do Something",
              changeStatus: changeStatus,
              deleteTask: deleteTask,
              editDescription: editTask,
              taskDataList: data, //complete task list
            ),
            TaskListScreen(
              addSubTask: addSubTask,
              changeSubStatus: changeSubStatus,
              deleteSubTask: deleteSubTask,
              emptyDisplayText: "No Active Task!!",
              changeStatus: changeStatus,
              deleteTask: deleteTask,
              editDescription: editTask,
              taskDataList: // contains active data list
                  data.where((element) => element.isActive == false).toList(),
            ),
            TaskListScreen(
              addSubTask: addSubTask,
              changeSubStatus: changeSubStatus,
              deleteSubTask: deleteSubTask,
              emptyDisplayText: "No Task Completed Yet Hurry Up!!",
              changeStatus: changeStatus,
              deleteTask: deleteTask,
              editDescription: editTask,
              taskDataList: //contains completed data list
                  data.where((element) => element.isActive == true).toList(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent[200],
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Container(
                child: AddEditTaskBox(
                  addeditDescription: addTask,
                ),
              ),
            );
          },
          tooltip: 'Add new note',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
