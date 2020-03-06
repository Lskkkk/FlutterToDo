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

  static double deleteButtonWidth = 90;
  bool onTouch = false;
  double distance = deleteButtonWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        final dx = details.delta.dx;
        if (dx < 0) {
          onScrollingLeft(dx);
        } else {
          onScrollingRight(dx);
        }
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        onScrollEnd();
      },
      child: Container(
          color: this.onTouch
              ? Color.fromRGBO(123, 12, 32, 0.5)
              : Color.fromRGBO(235, 235, 235, 0.5),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Row(children: <Widget>[
                Checkbox(
                    onChanged: (val) {
                      this.toggle(this.content);
                    },
                    value: this.isSelected),
                Text(
                  this.content,
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ])),
              Transform.translate(
                offset: Offset(distance, 0),
                child: Container(
                  width: deleteButtonWidth,
                  height: 60,
                  color: Color.fromRGBO(255, 50, 50, 0.4),
                  child: IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () {
                        this.delete(this.content);
                      }),
                ),
              )
            ],
          )),
    );
  }

  onScrollingLeft(dx) {
    if (distance == 0) return;
    if (distance < 0) {
      setState(() {
        distance = 0;
      });
    } else {
      setState(() {
        distance = (distance + dx) < 0 ? 0 : distance + dx;
      });
    }
  }

  onScrollEnd() {
    if (distance != 0) {
      setState(() {
        distance = deleteButtonWidth;
      });
    }
  }

  onScrollingRight(dx) {
    if (distance == deleteButtonWidth) return;
    if (distance > deleteButtonWidth - 10) {
      setState(() {
        distance = deleteButtonWidth;
      });
    } else {
      setState(() {
        distance += dx;
      });
    }
  }
}
