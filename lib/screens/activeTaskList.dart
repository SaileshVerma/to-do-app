import 'package:flutter/material.dart';
import 'package:todo/models/taskmodel.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                      getId: (value) {
                        setState(() {
                          widget
                              .activeData[widget.activeData.indexWhere(
                                  (element) => element.id == value.id)]
                              .isActive = value.isActive;
                          widget.getId(value);
                        });
                      },
                      getDeletedTitle: (val) {
                        setState(() {
                          widget.activeData.removeWhere((e) => e.title == val);
                          widget.getDeletedTitle(val);
                        });
                      },
                      getEditedTask: (v) {
                        if (v.title.isNotEmpty) {
                          setState(() {
                            widget
                                .activeData[widget.activeData
                                    .indexWhere((e) => e.title == v.title)]
                                .description = v.description;
                            widget.getEditedTask(v);
                          });
                        }
                      },
                      id: widget.activeData[i].id,
                      isAcitve: widget.activeData[i].isActive,
                      title: widget.activeData[i].title,
                      desc: widget.activeData[i].description)),
            ),
          ],
        ),
      ),
    );
  }
}
