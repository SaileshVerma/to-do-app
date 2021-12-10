import 'package:flutter/material.dart';
import '../models/taskmodel.dart';
import '../widget/emptyScreenText.dart';
import '../widget/taskGrid.dart';

// ignore: must_be_immutable
class TaskListScreen extends StatelessWidget {
  Function(String id) changeStatus;
  Function(String id) deleteTask;
  Function(String id, String title, String desc) editDescription;
  late List<TaskModel> taskDataList;
  late String emptyDisplayText;
  TaskListScreen({
    required this.emptyDisplayText,
    required this.deleteTask,
    required this.editDescription,
    required this.changeStatus,
    required this.taskDataList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: taskDataList.isEmpty
            ? EmptyScreenText(emptyDisplayText)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                      itemCount: taskDataList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 11,
                        mainAxisSpacing: 11,
                      ),
                      itemBuilder: (ctx, i) => TaskGrid(
                        // getAddedSubTask: (val) {
                        //   setState(() {
                        //     widget.activeData[i].subTaskData.add(val);
                        //   });
                        // },
                        changeStatus: changeStatus,
                        deleteTask: deleteTask,
                        editDescription: editDescription,
                        id: taskDataList[i].id,
                        isAcitve: taskDataList[i].isActive,
                        title: taskDataList[i].title,
                        desc: taskDataList[i].description,
                        subTaskData: taskDataList[i].subTaskData,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
