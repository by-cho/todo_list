// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docId;
  final String titleTask;
  final String description;
  final String label;
  final String date;
  final String time;
  final bool isDone;

  TodoModel({
    this.docId,
    required this.titleTask,
    required this.description,
    required this.label,
    required this.date,
    required this.time,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titleTask': titleTask,
      'description': description,
      'label': label,
      'date': date,
      'time': time,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docId: map['docId'] != null ? map['docId'] as String : null,
      titleTask: map['titleTask'] as String,
      description: map['description'] as String,
      label: map['label'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      docId: doc.id,
      titleTask: doc['titleTask'],
      description: doc['description'],
      label: doc['label'],
      date: doc['date'],
      time: doc['time'],
      isDone: doc['isDone'],
    );
  }
}
