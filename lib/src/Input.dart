import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final Function add;
  Input(this.add);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: TextField(
          controller: controller,
        ),
      ),
      FlatButton(
        child: Text('Add'),
        onPressed: addItem,
        color: Colors.blue,
      )
    ]);
  }

  addItem() {
    add(controller.text);
    controller.clear();
  }
}
