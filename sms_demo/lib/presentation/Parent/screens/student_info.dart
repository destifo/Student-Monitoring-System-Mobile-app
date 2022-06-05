import 'package:flutter/material.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';
import 'package:sms_demo/Domain/model/parent/student.dart';
import 'package:sms_demo/Domain/model/teacher/marklist.dart';
import 'package:sms_demo/presentation/Admin/widgets/Grade/cardTiles.dart';

import '../../auth/widgets/logout_button.dart';
import '../widgets/student_profile_card.dart';

class StudentInfo extends StatelessWidget {
  final Student student;
  StudentInfo({Key? key, required this.student}) : super(key: key);

  // late Student student = Student(
  //     studentName: currStudent.name,
  //     className: currStudent.sectionName,
  //     mark: [
  //       ...(markList.map((e) {
  //         return [
  //           e.subjectName,
  //           (e.assesment + e.finalExam + e.midTerm + e.testOne + e.testTwo)
  //         ];
  //       }))
  //     ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Information"),
        actions: [LogoutButton()]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    child: Icon(
                      Icons.grade,
                      size: 30,
                      color: Colors.lightBlueAccent,
                    ),
                    backgroundColor: Colors.white,
                    radius: 30),
                SizedBox(
                  height: 21,
                ),
                Text(
                  'Student Name: ${student.studentName}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Class: ${student.className}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: student.mark.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        cardTile(
                          title: Text(student.mark[index][0]),
                          trailing: Text(student.mark[index][1].toString()),
                        )
                      ],
                    );
                  }),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
