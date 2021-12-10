import 'package:flutter/material.dart';
import '../models/subtaskmodel.dart';

import '../models/taskmodel.dart';

// ignore: must_be_immutable
class EditTaskBox extends StatefulWidget {
  Function(String id, String title, String desc) editDescription;

  late String receviedTitle, receviedDesc, receivedId;
  late bool isActive;
  late List<SubTaskModel> datalist;

  EditTaskBox(
      {required this.editDescription,
      required this.datalist,
      required this.isActive,
      required this.receivedId,
      required this.receviedTitle,
      required this.receviedDesc});
  @override
  _EditTaskBoxState createState() => _EditTaskBoxState();
}

class _EditTaskBoxState extends State<EditTaskBox> {
  TaskModel obj = TaskModel(
      id: (DateTime.now()).toString(),
      description: "",
      title: "",
      subTaskData: []);

  late TextEditingController descController, titleController;
  @override
  void initState() {
    obj.id = widget.receivedId;
    obj.isActive = widget.isActive;
    obj.subTaskData = widget.datalist;

    titleController = TextEditingController(text: widget.receviedTitle);
    descController = TextEditingController(text: widget.receviedDesc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
            onPressed: () {
              widget.editDescription(obj.id, obj.title, obj.description);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("task edited successfully")));
              Navigator.pop(context);
            },
            child: Text("OK"))
      ],
      title: Text("Lets Add Today Work : )"),
      content: Container(
        height: 150,
        child: Column(
          children: [
            TextField(
              readOnly: true,
              controller: titleController,
              decoration: InputDecoration(
                hintText: "title",
              ),
            ),
            TextField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(hintText: "description"),
                onChanged: (_) {
                  obj.description = descController.text;
                  obj.title = titleController.text;
                }),
          ],
        ),
      ),
    );
  }
}
