import 'package:flutter/material.dart';

import 'models/taskmodel.dart';
import 'widget/addTaskbox.dart';
import 'data/dummyData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    void addTask() {
      showDialog(
        context: context,
        builder: (context) => Container(child: AddTaskBox(
          getaddedvalues: (a) {
            setState(() {
              TaskModel obj = new TaskModel(a.title, a.description);
              data.add(obj);
            });
          },
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child:
                //  ListView.builder(
                //     itemCount: data.length,
                //     itemBuilder: (ctx, i) => Text(data[i].title))

                ListView(
              children: data.map((e) => Text(e.title)).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTask(),
        tooltip: 'Add new note',
        child: Icon(Icons.add),
      ),
    );
  }
}
