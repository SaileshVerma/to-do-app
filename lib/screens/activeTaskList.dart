import 'package:flutter/material.dart';
import 'package:todo/models/taskmodel.dart';
import 'package:todo/widget/emptyScreenText.dart';
import 'package:todo/widget/taskGrid.dart';

// ignore: must_be_immutable
class ActiveTaskList extends StatefulWidget {
  Function(TaskModel) getId;
  Function(String) getDeletedTitle;
  Function(TaskModel) getEditedTask;
  late List<TaskModel> activeData;
  ActiveTaskList(
      {required this.getDeletedTitle,
      required this.getEditedTask,
      required this.getId,
      required this.activeData});

  @override
  _ActiveTaskListState createState() => _ActiveTaskListState();
}

class _ActiveTaskListState extends State<ActiveTaskList> {
  void changeStatus(TaskModel value, List<TaskModel> activeData) {
    setState(() {
      widget
          .activeData[
              widget.activeData.indexWhere((element) => element.id == value.id)]
          .isActive = value.isActive;
      widget.getId(value);
    });
  }

  void deleteTask(List<TaskModel> activeData, String val) {
    setState(() {
      widget.activeData.removeWhere((e) => e.title == val);
      widget.getDeletedTitle(val);
    });
  }

  void editDescription(List<TaskModel> activeData, TaskModel v) {
    setState(() {
      widget.activeData[widget.activeData.indexWhere((e) => e.title == v.title)]
          .description = v.description;
      widget.getEditedTask(v);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.activeData.isEmpty
            ? EmptyScreenText("No Active Task!!")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                        itemCount: widget.activeData.length,
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
                              getId: (value) {
                                changeStatus(value, widget.activeData);
                              },
                              getDeletedTitle: (val) {
                                deleteTask(widget.activeData, val);
                              },
                              getEditedTask: (v) {
                                if (v.title.isNotEmpty) {
                                  editDescription(widget.activeData, v);
                                }
                              },
                              id: widget.activeData[i].id,
                              isAcitve: widget.activeData[i].isActive,
                              title: widget.activeData[i].title,
                              desc: widget.activeData[i].description,
                              subTaskData: widget.activeData[i].subTaskData,
                            )),
                  ),
                ],
              ),
      ),
    );
  }
}
