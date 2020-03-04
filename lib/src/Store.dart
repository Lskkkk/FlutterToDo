import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class ToDoStore {
  final saveKey = 'flutter_todo_store';
  List<StoreItem> list = [];

  Future<bool> init() {
    return this._read();
  }

  List<StoreItem> get() {
    return list;
  }

  add(StoreItem item) {
    list.add(item);
    this._write();
  }

  toggle(String content) {
    list.forEach((i) {
      if (content == i.content) {
        i.isSelected = !i.isSelected;
      }
    });
    this._write();
  }

  Future<bool> _read() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> storeData = prefs.getStringList(this.saveKey);
    this.list = [];
    storeData.forEach((data) {
      final item = StoreItem.toItem(data);
      if (item != null) {
        this.add(item);
      }
    });
    return true;
  }

  _write() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(this.saveKey, this._serialize());
  }

  List<String> _serialize() {
    List<String> itemStr = [];
    this.list.forEach((item) {
      itemStr.add(StoreItem.toStr(item));
    });
    return itemStr;
  }
}

class StoreItem {
  bool isSelected;
  String content;

  StoreItem(this.isSelected, this.content);

  static toStr(StoreItem item) {
    return [item.isSelected, item.content].join(';');
  }

  static StoreItem toItem(String str) {
    var values = str.split(';');
    if (values.length < 2) return null;
    return StoreItem(values[0] == 'true', values[1]);
  }
}
