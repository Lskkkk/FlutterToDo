import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: TextField(),
      ),
      FlatButton(
        child: Text('Add'),
        onPressed: () {},
        color: Colors.blue,
      )
    ]);
  }
}
