import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddEditTaskBox extends StatelessWidget {
  Function(String title, String desc) addeditDescription;

  final TextEditingController titleInputController;
  final TextEditingController descriptionInputController;
  AddEditTaskBox({
    required this.addeditDescription,
    receivedTitle = "",
    receivedDesc = "",

    // required this.datalist,
    // required this.isActive,
    // required this.receivedId,
    // required this.receviedTitle,
    // required this.receviedDesc
  })  : descriptionInputController = TextEditingController(text: receivedDesc),
        titleInputController = TextEditingController(text: receivedTitle);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      actions: [
        TextButton(
            onPressed: () {
              addeditDescription(
                titleInputController.text,
                descriptionInputController.text,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text("task edited successfully"),
                ),
              );
              Navigator.pop(context);
            },
            child: Text("OK"))
      ],
      title: Text("Lets Edit : ) "),
      content: Container(
        height: 150,
        child: Column(
          children: [
            TextField(
              controller: titleInputController,
              decoration: InputDecoration(
                hintText: "title",
              ),
            ),
            TextField(
              controller: descriptionInputController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 6,
              decoration: InputDecoration(hintText: "description"),
            ),
          ],
        ),
      ),
    );
  }
}
