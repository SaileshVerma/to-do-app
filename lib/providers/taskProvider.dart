import 'package:flutter/cupertino.dart';

import '../models/subtaskmodel.dart';
import '../models/taskmodel.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _taskdata = [
    TaskModel(
      id: "1",
      title: "Meeting",
      description: "attend a meeting at 3 PM todayMtend a meeting at 3 PM",
      subTaskData: [
        SubTaskModel(
          id: "1",
          title: "meeting 1",
        ),
        SubTaskModel(
          id: "2",
          title: "meeting 2",
        ),
        SubTaskModel(
          id: "3",
          title: "meeting 3",
        ),
        SubTaskModel(
          id: "4",
          title: "meeting 4",
        ),
        SubTaskModel(
          id: "5",
          title: "meeting 5",
        ),
      ],
    ),
    TaskModel(
      isActive: false,
      id: "2",
      title: "Assignment",
      description: "complete all the pending assignment of lab practical",
      subTaskData: [],
    ),
    TaskModel(
      isActive: false,
      id: "3",
      title: "Maths Assignment",
      description: "submit the maths assignemnt to your teacher",
      subTaskData: [],
    ),
    TaskModel(
      isActive: false,
      id: "4",
      title: "Call ur friend",
      description: "tell ur friend about the work assign by the teacher",
      subTaskData: [],
    ),
  ];

  List<TaskModel> get taskdata {
    return _taskdata;
  }

  List<TaskModel> get activeTaskList {
    final list =
        taskdata.where((element) => element.isActive == false).toList();
    notifyListeners();
    return list;
  }

  List<TaskModel> get completedTaskList {
    final list = taskdata.where((element) => element.isActive == true).toList();
    notifyListeners();
    return list;
  }

  void changeStatus(String id) {
    final item = taskdata.firstWhere((element) => element.id == id);

    item.toggleStatus();
    notifyListeners();
  }

  void deleteTask(String id) {
    taskdata.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void editTask(String id, String title, String desc) {
    final item = taskdata.firstWhere((element) => element.id == id);

    item.title = title;
    item.description = desc;
    notifyListeners();
  }

  void addTask(String title, String desc) {
    final item = TaskModel(
      id: DateTime.now().toString(),
      title: title,
      description: desc,
      subTaskData: [],
    );

    taskdata.add(item);
    notifyListeners();
  }

  void reorderable(itemId, oldindex, newindex) {
    if (oldindex < newindex) {
      newindex = newindex - 1;
      final item = taskdata.firstWhere((element) => element.id == itemId);
      final subitem = (item.subTaskData).removeAt(oldindex);
      item.subTaskData.insert(newindex, subitem);
      notifyListeners();
    }
  }

  void addSubTask(String itemId, String title) {
    final subItem = SubTaskModel(
      id: DateTime.now().toString(),
      title: title,
    );
    final item = taskdata.firstWhere(
      (element) => element.id == itemId,
    );

    item.subTaskData.add(subItem);
    notifyListeners();
  }

  void deleteSubTask(String subitemId, String itemId) {
    final item = taskdata.firstWhere((element) => element.id == itemId);

    item.subTaskData.removeWhere((e) => e.id == subitemId);
    notifyListeners();
  }

  void changeSubStatus(String subitemId, String itemId) {
    final item = taskdata.firstWhere((element) => element.id == itemId);

    final subItem =
        item.subTaskData.firstWhere((element) => element.id == subitemId);

    subItem.toggleSubStatus();
    notifyListeners();
  }
}
