import 'package:flutter/material.dart';
import 'package:todo/widget/taskGrid.dart';

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
          getaddedvalues: (i) {
            setState(() {
              TaskModel obj = new TaskModel(i.title, i.description);
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 11,
                    mainAxisSpacing: 11,
                  ),
                  itemBuilder: (ctx, i) =>
                      TaskGrid(data[i].title, data[i].description)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTask(),
        tooltip: 'Add new note',
        child: Icon(Icons.add),
      ),
    );
  }
}
