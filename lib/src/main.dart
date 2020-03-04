import 'package:flutter/material.dart';
import 'package:flutter_todo/src/Input.dart';
import 'package:flutter_todo/src/Item.dart';
import 'package:flutter_todo/src/Store.dart';

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To Do',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  ToDoStore store = ToDoStore();

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  Widget build(BuildContext context) {
    var list = store.get();
    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo List'),
        ),
        body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Input(add),
                ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Item(
                          // key有两个作用：1. 根据key去标识一个组件实例是否需要更新状态。2. key相同时即使数据不同，界面不会刷新。
                          ValueKey(list[index].content +
                              list[index].isSelected.toString()),
                          list[index].content,
                          list[index].isSelected,
                          this.toggle,
                          this.delete);
                    },
                    shrinkWrap: true)
              ],
            )));
  }

  void _load() {
    store.init().then((val) => setState(() {}));
  }

  void toggle(content) {
    store.toggle(content);
    setState(() {});
  }

  void add(content) {
    store.add(StoreItem(false, content));
    setState(() {});
  }

  void delete(content) {
    store.delete(content);
    setState(() {});
  }
}
