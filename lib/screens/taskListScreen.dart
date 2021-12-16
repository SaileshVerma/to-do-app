import 'package:flutter/material.dart';

import '../models/taskmodel.dart';
import '../widget/emptyScreenText.dart';
import '../widget/taskGrid.dart';

class TaskListScreen extends StatelessWidget {
  final List<TaskModel> taskDataList;
  final String emptyDisplayText;
  TaskListScreen({
    required this.emptyDisplayText,
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
                        id: taskDataList[i].id,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
