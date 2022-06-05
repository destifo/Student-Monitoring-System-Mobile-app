import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Bloc/TeacherAccountManagement/TeacherAccBloc.dart';
import 'package:sms_demo/Bloc/TeacherAccountManagement/TeacherAccEvent.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/parent_form.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/teacher_form.dart';

import '../../../../Domain/model/admin/Management/teacher_model.dart';

class Teacher extends StatefulWidget {
  TeacherModel teacher;

  Teacher({Key? key, required this.teacher}) : super(key: key);

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  final sections = [];
  @override
  void initState() {
    for (var section in widget.teacher.sections) {
      if (section != "") {
        sections.add(section);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.teacher.id),
      background: Container(
        color: Colors.red,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.delete)]),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        BlocProvider.of<TeacherAccBloc>(context)
            .add(DeleteTeacherAcc(id: widget.teacher.id!));
      },
      child: Card(
          child: ListTile(
        leading: CircleAvatar(
          backgroundImage: widget.teacher.gender == "male"
              ? AssetImage("assets/male.jpeg")
              : AssetImage("assets/female.png"),
          radius: 30,
        ),
        title: Text(widget.teacher.name),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.teacher.username),
              Text(sections.toString())
            ]),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            GoRouter.of(context).goNamed(
              'edit teacher',
              extra: widget.teacher,
            );
          },
        ),
      )),
    );
  }
}
