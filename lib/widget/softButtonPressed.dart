import 'package:flutter/material.dart';

class SoftButtonPressed extends StatelessWidget {
  final Icon icon;
  final void Function() func;

  SoftButtonPressed({
    required this.icon,
    required this.func,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.all(6),
          child: IconButton(
            onPressed: func,
            icon: icon,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Colors.grey.shade600,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade700,
                    Colors.grey.shade600,
                    Colors.grey.shade500,
                    Colors.grey.shade200,
                  ],
                  stops: [
                    0,
                    0.1,
                    0.3,
                    1
                  ])),
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
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
                  Colors.white24,
                  Colors.white30,
                  Colors.white38,
                  Colors.white54,
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
