import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmptyScreenText extends StatelessWidget {
  String msg;
  EmptyScreenText(this.msg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 22,
              color: Colors.grey[500],
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
