import 'package:crud_project_android/utils.dart';
import 'package:flutter/material.dart';

class TodoField {
  static const createdTime = "createdTime";
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;
  String userUid;

  Todo(this.createdTime, this.title, this.id, this.description, this.isDone,
      this.userUid);

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        Utils.toDateTime(json['createdTime']),
        json['title'],
        json['id'],
        json['description'],
        json['isDone'],
        json['userUid'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
        'userUid': userUid,
      };
}
