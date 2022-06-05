import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Domain/model/admin/Grades/Sections.dart';
import 'package:sms_demo/presentation/Admin/screens/Grades/Students_List.dart';
import 'package:sms_demo/presentation/Admin/widgets/Grade/cardTiles.dart';

class Sectionlist extends StatelessWidget {
  const Sectionlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 5,
          );
        },
        itemCount: Sections.section.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              cardTile(
                title: Text(Sections.section[index]),
                trailing: Icon(Icons.home),
                tap: () {
                  GoRouter.of(context).goNamed('section list',
                      params: {'sectionName': 'Section 1A'});
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             StudentsScreen(SectionName: "Section 1A")));
                },
              )
            ],
          );
        });
  }
}
