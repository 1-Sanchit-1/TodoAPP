import 'package:flutter/material.dart';

class Todo {
  String task;
  String taskDec;
  bool? ischecked ;

  Todo({required this.task, required this.taskDec, this.ischecked}) {
    task = this.task;
    taskDec = this.taskDec;
    ischecked = this.ischecked = false;
  }

  toJson() {
    return {
      "task": task ,
      "taskDec": taskDec ,
      "ischeched": ischecked ,
    };
  }

  fromJson(jsondata) {
    return Todo(
      task: jsondata['task'],
      taskDec: jsondata['taskDec'],
      ischecked: jsondata['ischecked']  ,
    );
  }
}
