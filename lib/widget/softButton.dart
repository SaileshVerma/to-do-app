import 'package:flutter/material.dart';

class SoftButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final void Function() func;

  SoftButton({
    required this.icon,
    required this.func,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(6),
        child: IconButton(
          icon: icon,
          onPressed: func,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
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
