import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/taskProvider.dart';
import '../widget/addEditTaskbox.dart';

import '../screens/taskListScreen.dart';

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    final data = taskprovider.taskdata;
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
              emptyDisplayText: "Lets Do Something",
              taskDataList: data, //complete task list
            ),
            TaskListScreen(
              emptyDisplayText: "No Active Task!!",
              taskDataList:
                  taskprovider.activeTaskList, // contains active data list
            ),
            TaskListScreen(
              emptyDisplayText: "No Task Completed Yet Hurry Up!!",
              taskDataList:
                  taskprovider.completedTaskList, //contains completed data list
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
                  addeditDescription: taskprovider.addTask,
                ),
              ),
            );
          },
          tooltip: 'Add new note',
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
