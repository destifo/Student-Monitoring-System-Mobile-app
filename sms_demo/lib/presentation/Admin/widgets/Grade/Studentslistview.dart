import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Domain/model/admin/Grades/Students.dart';
import 'package:sms_demo/presentation/Admin/screens/Grades/Grades.dart';
import 'package:sms_demo/presentation/Admin/widgets/Grade/cardTiles.dart';

class Studentslist extends StatelessWidget {
  final String sectionName;
  Studentslist({required this.sectionName});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 5,
          );
        },
        itemCount: Students.students.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              cardTile(
                title: Text(Students.students[index]),
                trailing: Icon(Icons.home),
                tap: () {
                  GoRouter.of(context).goNamed(
                    'view student grade admin',
                    params: {'studentid': '001', 'sectionName': sectionName},
                  );
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => GradeScreen()));
                },
              )
            ],
          );
        });
  }
}
