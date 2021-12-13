import 'package:flutter/material.dart';

class EmptyScreenText extends StatelessWidget {
  final String msg;
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
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
