import 'package:flutter/material.dart';
import 'package:todo/models/taskmodel.dart';
import 'package:todo/widget/taskGrid.dart';

// ignore: must_be_immutable
class CompletedTaskList extends StatefulWidget {
  Function(TaskModel) getId;
  Function(String) getDeletedTitle;
  Function(TaskModel) getEditedTask;
  late List<TaskModel> completeList;
  CompletedTaskList(
      {required this.getDeletedTitle,
      required this.getEditedTask,
      required this.getId,
      required this.completeList});

  @override
  _CompletedTaskListState createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.completeList.isEmpty
            ? Center(
                child: Container(
                  child: Text(
                    "No Task Completed Yet Hurry Up!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
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
                        itemCount: widget.completeList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 11,
                          mainAxisSpacing: 11,
                        ),
                        itemBuilder: (ctx, i) => TaskGrid(
                            getId: (value) {
                              setState(() {
                                widget
                                    .completeList[widget.completeList
                                        .indexWhere((element) =>
                                            element.id == value.id)]
                                    .isActive = value.isActive;
                                widget.getId(value);
                              });
                            },
                            getDeletedTitle: (val) {
                              setState(() {
                                widget.completeList
                                    .removeWhere((e) => e.title == val);
                                widget.getDeletedTitle(val);
                              });
                            },
                            getEditedTask: (v) {
                              if (v.title.isNotEmpty) {
                                setState(() {
                                  widget
                                      .completeList[widget.completeList
                                          .indexWhere(
                                              (e) => e.title == v.title)]
                                      .description = v.description;
                                  widget.getEditedTask(v);
                                });
                              }
                            },
                            id: widget.completeList[i].id,
                            isAcitve: widget.completeList[i].isActive,
                            title: widget.completeList[i].title,
                            desc: widget.completeList[i].description)),
                  ),
                ],
              ),
      ),
    );
  }
}
