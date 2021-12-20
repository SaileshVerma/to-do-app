import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/taskProvider.dart';

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
    final taskprovider = Provider.of<TaskProvider>(context);

    void deleteItem(String id, int index) {
      listkey.currentState!.removeItem(
        index,
        (context, animation) =>
            // Text("data"),
            TaskGrid(
          id: id,
          index: index,
          animation: animation,
          deleteItem: (id, index) {},
        ),
        duration: Duration(milliseconds: 500),
      );
      // taskDataList.removeAt(index);
      // taskprovider.deleteTask(id);
      // print("runn ?>>>>>>>>>>");
    }

    print("runn ?>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" +
        taskDataList.length.toString());
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: taskDataList.isEmpty
            ? EmptyScreenText(emptyDisplayText)
            : AnimatedList(
                key: listkey,
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                initialItemCount: taskDataList.length,
                itemBuilder: (ctx, i, animation) => TaskGrid(
                  index: i,
                  animation: animation,
                  deleteItem: deleteItem,
                  id: taskDataList[i].id,
                ),
              ),
      ),
    );
  }
}
