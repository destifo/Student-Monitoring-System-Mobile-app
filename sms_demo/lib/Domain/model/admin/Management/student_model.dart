import 'package:flutter/material.dart';

class ParentModel{
    String name;
    String username;
    String gender;
    String sectionName;
    String? password;
    String? id;
    
    ParentModel({Key? key,this.password,this.id, required this.name, required this.username, required this.gender,required this.sectionName });
  factory ParentModel.fromJson(Map<String, dynamic> json) {
   return ParentModel(
     id: json['_id'],
     name: json['name'],
     gender: json['gender'],
     sectionName: json['sectionName'],
     username: json['username']
   );
 }

}

