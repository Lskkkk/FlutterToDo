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
        onTapUp: (TapUpDetails details) {
          this.toggle(this.content);
        },
        child: Container(
          color: this.onTouch
              ? Color.fromRGBO(123, 12, 32, 0.5)
              : Color.fromRGBO(235, 235, 235, 0.5),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          height: 80,
          child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Text(this.content,
                      style: isSelected
                          ? TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(30, 30, 30, 0.3),
                              decoration: TextDecoration.lineThrough)
                          : TextStyle(fontSize: 20, color: Colors.black87),
                      overflow: TextOverflow.ellipsis),
                  Positioned( // 删除按钮使用绝对定位，配合Stack使用
                    child: Transform.translate(
                      offset: Offset(distance, 0),
                      child: Container(
                        width: deleteButtonWidth,
                        color: Color.fromRGBO(255, 50, 50, 1),
                        child: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                              this.delete(this.content);
                            }),
                      ),
                    ),
                    bottom: 0,
                    right: 0,
                    top: 0,
                  )
                ],
              )),
        ));
  }

  onScrollingLeft(dx) {
    if (distance == 0) return;
    if (distance < 0) {
      setState(() {
        distance = 0;
      });
    } else {
      setState(() {
        distance = (distance + dx) < 20 ? 0 : distance + dx;
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
