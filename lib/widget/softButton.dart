import 'package:flutter/material.dart';

class SoftButton extends StatelessWidget {
  final Widget child;
  SoftButton(this.child);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(20),
        child: child,
        // IconButton(
        //   icon: Icon(Icons.delete),
        //   onPressed: () {},
        //   color: Colors.grey[800],
        // ),
        decoration: BoxDecoration(

            //shape: BoxShape.circle,
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade600,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade200,
                  Colors.grey.shade300,
                  Colors.grey.shade400,
                  Colors.grey.shade500,
                ],
                stops: [
                  0.1,
                  0.3,
                  0.8,
                  1
                ])),
      ),
    );
  }
}
