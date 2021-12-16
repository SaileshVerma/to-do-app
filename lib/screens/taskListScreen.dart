import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/taskProvider.dart';
import '../models/taskmodel.dart';
import '../widget/emptyScreenText.dart';
import '../widget/taskGrid.dart';

class TaskListScreen extends StatelessWidget {
  // final void Function(String id) changeStatus;
  // final void Function(String id) deleteTask;
  // final void Function(String id, String title, String desc) editDescription;
  // final void Function(String itemid, String title) addSubTask;
  // final void Function(String subitemId, String itemid) deleteSubTask;
  // final void Function(String subitemId, String itemId) changeSubStatus;

  final List<TaskModel> taskDataList;
  final String emptyDisplayText;
  TaskListScreen({
    required this.emptyDisplayText,
    // required this.deleteTask,
    // required this.editDescription,
    // required this.changeStatus,
    // required this.addSubTask,
    // required this.changeSubStatus,
    // required this.deleteSubTask,
    required this.taskDataList,
  });

  @override
  Widget build(BuildContext context) {
    // final taskprovider = Provider.of<TaskProvider>(context);
    // final taskDataList = taskprovider.taskdata;
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
                        // addSubTask: addSubTask,
                        // changeSubStatus: changeSubStatus,
                        // deleteSubTask: deleteSubTask,
                        // changeStatus: changeStatus,
                        // deleteTask: deleteTask,
                        // editDescription: editDescription,
                        id: taskDataList[i].id,
                        // isAcitve: taskDataList[i].isActive,
                        // title: taskDataList[i].title,
                        // desc: taskDataList[i].description,
                        // subTaskData: taskDataList[i].subTaskData,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
