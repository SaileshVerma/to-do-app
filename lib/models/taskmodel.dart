import 'package:todo/models/subtaskmodel.dart';

class TaskModel {
  String title;
  String description;
  String id;
  bool isActive;
  List<SubTaskModel> subTaskData;

  TaskModel(
      {this.isActive = false,
      required this.id,
      required this.title,
      required this.description,
      required this.subTaskData});
}
