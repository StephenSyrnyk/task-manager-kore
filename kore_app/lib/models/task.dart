import 'package:flutter/material.dart';
import 'package:kore_app/data/api.dart';

class Task {
  int id;
  String title;
  bool isCompleted;
  String description;
  DateTime dueDate;
  DateTime dateCreated;
  int status;
  Object color;
  Object icon;
  String label;

  void setStatus(Api api){
    if (isCompleted == true) {
      this.color = Colors.green;
      this.icon = Icons.done;
      this.label = "Complete";      
    } else {
      this.color = Colors.redAccent;
      this.icon = Icons.cancel;
      this.label = "Not Complete";
    }
  }

  Task({
    this.id,
    this.title,
    this.isCompleted,
    this.status,
    this.description,
    this.dueDate
    });

  factory Task.fromJson(Map<String, dynamic> json ) {
    Task task = Task(
        id: json['id'] as int,
        title: json['subject'] as String,
        // isCompleted: true,
        status: json['status'] as int,
        description: json['description'] as String,
        dueDate: json['DueDate'] as DateTime 
    );

    if(task.status == 0){
      task.isCompleted = false;
    } else{
      task.isCompleted = true;
    }
    
    if (task.isCompleted == true) {
      task.color = Colors.green;
      task.icon = Icons.done;
      task.label = "Complete";
    } else {
      task.color = Colors.redAccent;
      task.icon = Icons.cancel;
      task.label = "Not Complete";
    }
    return task;
  }
}