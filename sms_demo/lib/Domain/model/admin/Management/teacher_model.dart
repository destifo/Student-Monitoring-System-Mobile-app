import 'package:flutter/material.dart';

class TeacherModel {
  String name;
  String username;
  String gender;
  List<dynamic> sections;
  String subjectName;
  String? password;
  String? id;

  TeacherModel(
      {Key? key,
      this.id,
      required this.name,
      required this.username,
      required this.gender,
      required this.subjectName,
      this.password,
      required this.sections});

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
        id: json['_id'],
        name: json['name'],
        gender: json['gender'],
        subjectName: json['subjectName'],
        sections: json['sections'],
        username: json['username']);
  }
}
