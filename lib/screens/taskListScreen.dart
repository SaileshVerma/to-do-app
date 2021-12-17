import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/taskProvider.dart';

import '../models/taskmodel.dart';
import '../widget/emptyScreenText.dart';
import '../widget/taskGrid.dart';

class TaskListScreen extends StatelessWidget {
  final listkey = GlobalKey<AnimatedListState>();
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
            : AnimatedList(
                key: listkey,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                initialItemCount: taskDataList.length,
                itemBuilder: (ctx, i, animation) => TaskGrid(
                  id: taskDataList[i].id,
                ),
              ),
      ),
    );
  }
}
