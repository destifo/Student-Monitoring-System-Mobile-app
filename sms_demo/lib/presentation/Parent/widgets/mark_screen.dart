import 'package:flutter/material.dart';
import 'package:sms_demo/Domain/model/admin/Grades/Grades.dart';
import 'package:sms_demo/presentation/Admin/widgets/Grade/cardTiles.dart';

class MarkScreen extends StatelessWidget {
  const MarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          cardTile(
              title: Text("Test 1"),
              trailing: Text(Grades.marks[1].test1.toString())),
          cardTile(
            title: Text("Test 2"),
            trailing: Text(Grades.marks[1].test2.toString()),
          ),
          cardTile(
            title: Text("Assignment"),
            trailing: Text(Grades.marks[1].Assignment.toString()),
          ),
          cardTile(
            title: Text("Mid"),
            trailing: Text(Grades.marks[1].mid.toString()),
          ),
          cardTile(
            title: Text("Final"),
            trailing: Text(Grades.marks[1].Final.toString()),
          )
        ],
      ),
    );
  }
}
