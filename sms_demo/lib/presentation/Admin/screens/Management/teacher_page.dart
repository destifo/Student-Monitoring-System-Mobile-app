import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Domain/model/admin/Management/teacher_model.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/teacher.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/teacher_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/TeacherAccountManagement/TeacherAccBloc.dart';
import '../../../../Bloc/TeacherAccountManagement/TeacherAccEvent.dart';
import '../../../../Bloc/TeacherAccountManagement/TeacherAccState.dart';
import '../../../auth/widgets/logout_button.dart';

class TeacherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Teacher"), actions: [LogoutButton()]),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
           GoRouter.of(context).pushNamed('add teacher');
          },
        ),
        body: BlocBuilder<TeacherAccBloc, TeacherAccState>(
          builder: (context, state) {
            if (state is TeachersLoading ) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TeachersLoadingFailed) {
              return Text("some error");
            }
            if (state is TeachersLoaded) {
              return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                              itemCount: state.teachers.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 5,
                                );
                              },
                              itemBuilder: (context, index) {
                                return Teacher(teacher: state.teachers[index]);
                              }))
                    ],
                  ));
            }
            return const Text("");
          },
        ));
  }
}
