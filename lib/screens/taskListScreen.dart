import 'package:flutter/material.dart';
import '../models/taskmodel.dart';
import '../widget/emptyScreenText.dart';
import '../widget/taskGrid.dart';

// ignore: must_be_immutable
class TaskListScreen extends StatefulWidget {
  Function(String) changeStatus;
  Function(String) setDeletedTitle;
  Function(String id, String title, String desc) editDescription;
  late List<TaskModel> taskDataList;
  late String emptyDisplayText;
  TaskListScreen({
    required this.emptyDisplayText,
    required this.setDeletedTitle,
    required this.editDescription,
    required this.changeStatus,
    required this.taskDataList,
  });

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  void deleteTask(String title) {
    setState(() {
      widget.taskDataList.removeWhere((e) => e.title == title);
      widget.setDeletedTitle(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.taskDataList.isEmpty
            ? EmptyScreenText(widget.emptyDisplayText)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                      itemCount: widget.taskDataList.length,
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
                        changeStatus: widget.changeStatus,
                        setDeletedTitle: deleteTask,
                        editDescription: widget.editDescription,
                        id: widget.taskDataList[i].id,
                        isAcitve: widget.taskDataList[i].isActive,
                        title: widget.taskDataList[i].title,
                        desc: widget.taskDataList[i].description,
                        subTaskData: widget.taskDataList[i].subTaskData,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
