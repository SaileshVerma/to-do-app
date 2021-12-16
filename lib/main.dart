import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/taskProvider.dart';
import 'screens/homePageScreen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TaskProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          unselectedWidgetColor: Colors.white,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
