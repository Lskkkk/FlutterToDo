import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  final String content;
  final bool isSelected;
  final Function toggle;
  final Function delete;
  Item(Key key, this.content, this.isSelected, this.toggle, this.delete)
      : super(key: key);

  @override
  _Item createState() =>
      _Item(this.content, this.isSelected, this.toggle, this.delete);
}

class _Item extends State<Item> {
  final String content;
  final bool isSelected;
  final Function toggle;
  final Function delete;
  _Item(this.content, this.isSelected, this.toggle, this.delete);

  bool onTouch = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        setState(() {
          onTouch = true;
        });
      },
      onLongPressEnd: (LongPressEndDetails details) {
        setState(() {
          onTouch = false;
        });
        this.delete(this.content);
      },
      child: Container(
          color: this.onTouch
              ? Color.fromRGBO(123, 12, 32, 0.5)
              : Color.fromRGBO(235, 235, 235, 0.5),
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
              ),
            ],
          )),
    );
  }
}
