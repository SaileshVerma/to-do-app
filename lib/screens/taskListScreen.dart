import 'package:flutter/material.dart';
import 'package:todo/models/taskmodel.dart';
import 'package:todo/widget/emptyScreenText.dart';
import 'package:todo/widget/taskGrid.dart';

// ignore: must_be_immutable
class TaskListScreen extends StatefulWidget {
  Function(TaskModel) setId;
  Function(String) setDeletedTitle;
  Function(TaskModel) setEditedTask;
  late List<TaskModel> taskDataList;
  late String emptyDisplayText;
  TaskListScreen(
      {required this.emptyDisplayText,
      required this.setDeletedTitle,
      required this.setEditedTask,
      required this.setId,
      required this.taskDataList});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  void changeStatus(TaskModel value, List<TaskModel> activeData) {
    setState(() {
      widget
          .taskDataList[widget.taskDataList
              .indexWhere((element) => element.id == value.id)]
          .isActive = value.isActive;
      widget.setId(value);
    });
  }

  void deleteTask(List<TaskModel> activeData, String val) {
    setState(() {
      widget.taskDataList.removeWhere((e) => e.title == val);
      widget.setDeletedTitle(val);
    });
  }

  void editDescription(List<TaskModel> activeData, TaskModel v) {
    setState(() {
      widget
          .taskDataList[
              widget.taskDataList.indexWhere((e) => e.title == v.title)]
          .description = v.description;
      widget.setEditedTask(v);
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
                        setId: (value) {
                          changeStatus(value, widget.taskDataList);
                        },
                        setDeletedTitle: (val) {
                          deleteTask(widget.taskDataList, val);
                        },
                        setEditedTask: (v) {
                          if (v.title.isNotEmpty) {
                            editDescription(widget.taskDataList, v);
                          }
                        },
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
