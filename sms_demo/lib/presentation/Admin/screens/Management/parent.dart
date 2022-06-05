import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/parent_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/ParentAccountManagement/ParAccBloc.dart';
import '../../../../Bloc/ParentAccountManagement/ParAccEvent.dart';
import '../../../../Bloc/ParentAccountManagement/ParrAccState.dart';
class Parent extends StatelessWidget {
  ParentModel parent;

  Parent({Key? key, required this.parent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(parent.id),
      background: Container(
        color: Colors.red,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.delete)]),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        BlocProvider.of<ParAccBloc>(context).add(DeleteParAcc(id: parent.id!));
      },
      child: Card(
          child: ListTile(
        leading: CircleAvatar(
          backgroundImage: parent.gender == "male"
              ? AssetImage("assets/male.jpeg")
              : AssetImage("assets/female.png"),
          radius: 30,
        ),
        title: Text(parent.name),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(parent.username),
              Text(parent.sectionName)
            ]),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            GoRouter.of(context).goNamed(
              'edit parent',
              extra: parent,
            );
          },
        ),
      )),
    );
  }
}