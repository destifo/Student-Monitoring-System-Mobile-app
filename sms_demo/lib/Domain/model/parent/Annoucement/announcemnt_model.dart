import 'package:equatable/equatable.dart';

class Announcemnt extends Equatable {
  String? id;
  String title;
  String body;
  DateTime? createTime;
  DateTime? lastEdited;

  Announcemnt(
    {
      required this.body, this.createTime, required this.title, this.id, this.lastEdited
    }
  );

  @override
  List<Object> get props => [title, body];

  factory Announcemnt.fromJson(Map<String, dynamic> json) {
    String body = json['body'];
    String id = json['_id'];
    DateTime createTime = DateTime.parse(json['createTime']);
    DateTime lastEdited = DateTime.parse(json['lastEdited']);
    String title = json['title'];
    Announcemnt announcemnt =
        Announcemnt(body: body, title: title, createTime: createTime, id: id, lastEdited: lastEdited);
    return announcemnt;
  }
}
