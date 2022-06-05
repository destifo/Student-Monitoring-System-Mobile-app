import 'package:flutter/material.dart';
import 'package:sms_demo/Domain/model/admin/Grades/Grades.dart';
import 'package:sms_demo/presentation/Admin/screens/Grades/marks.dart';
import 'package:sms_demo/presentation/Admin/widgets/Grade/cardTiles.dart';

class Gradelist extends StatelessWidget {
  const Gradelist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 5,
          );
        },
        itemCount: Grades.marks.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              cardTile(
                title: Text(Grades.marks[index].Subject),
                trailing: Text(Grades.marks[index].Total.toString()),
                tap: () {
                  {
                    showModalBottomSheet(
                        context: context, builder: (context) => markScreen());
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => StudentsScreen()));
                },
              )
            ],
          );
        });
  }
}
