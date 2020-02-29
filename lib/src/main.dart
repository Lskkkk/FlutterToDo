import 'package:flutter/material.dart';
import 'package:flutter_todo/src/Input.dart';
import 'package:flutter_todo/src/Item.dart';

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To Do',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo List'),
        ),
        body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Input(),
                Item('eat some food', true),
                Item('drink some water', true),
                Item('sleep for a while', false)
              ],
            )));
  }
}
