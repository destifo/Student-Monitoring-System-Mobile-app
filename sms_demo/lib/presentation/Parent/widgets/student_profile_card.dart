import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Domain/model/parent/student.dart';

class StudentProfileCard extends StatelessWidget {
  final Student student;
  const StudentProfileCard({
    Key? key,
    required this.student,
  }) : super(key: key);

  final TextStyle txtStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 19,
  );

  final TextStyle infoStyle = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: const EdgeInsets.only(
        left: 15,
        top: 20,
        bottom: 20,
        right: 15,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Center(
                  child: const Icon(
                    Icons.person_rounded,
                    size: 180,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${student.studentName}',
                        style: infoStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Class: ${student.className}',
                        style: infoStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Other general info',
                        style: infoStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
            // const SizedBox(
            //   width: 20,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Student',
                  // softWrap: false,
                  // overflow: TextOverflow.clip,
                  // maxLines: 3,
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                const Text(
                  'Mark',
                  // softWrap: false,
                  // overflow: TextOverflow.clip,
                  // maxLines: 3,
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                // const Text(
                //   'Overview',
                //   softWrap: false,
                //   overflow: TextOverflow.clip,
                //   maxLines: 3,
                //   style: TextStyle(
                //     fontSize: 23,
                //   ),
                // ),
                const SizedBox(
                  height: 19,
                ),
                ListView.builder(
                    itemCount: student.mark.length,
                    itemBuilder: (context, index) {
                      return Text(
                        '${student.mark[index][0]}: ${student.mark[index][1]}',
                        style: txtStyle,
                      );
                    }),
                // Container(
                //   height: 40,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                //   ),
                //   child: TextButton(
                //     onPressed: () {
                //       context.goNamed(
                //         'student mark',
                //         params: {'id': '02'},
                //       );
                //     },
                //     child: const Text(
                //       'View more',
                //       style: TextStyle(
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
