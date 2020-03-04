import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String content;
  final bool isSelected;
  final Function toggle;
  Item(this.content, this.isSelected, this.toggle);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(235, 235, 235, 0.5),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
        padding: EdgeInsets.fromLTRB(5, 8, 0, 8),
        child: Row(
          children: <Widget>[
            Checkbox(
                onChanged: (val) {
                  this.toggle(this.content);
                },
                value: this.isSelected),
            Text(
              this.content,
              style: TextStyle(fontSize: 20, color: Colors.black87),
            )
          ],
        ));
  }
}
