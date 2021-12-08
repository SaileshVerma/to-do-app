import 'package:todo/models/subtaskmodel.dart';

class TaskModel {
  String title;
  String description;
  String id;
  bool isActive;
  List<SubTaskModel> subTaskData;
  TaskModel(
      this.isActive, this.id, this.title, this.description, this.subTaskData);
}
