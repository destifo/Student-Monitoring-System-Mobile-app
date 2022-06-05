import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Bloc/marklist_bloc/marklist_bloc.dart';
import 'package:sms_demo/Bloc/profile_bloc/teacher_bloc.dart';

import '../../auth/widgets/logout_button.dart';
import 'FillMark.dart';
import 'PopUpProfile.dart';

class TeacherHome extends StatelessWidget {
  TeacherHome({Key? key}) : super(key: key);
  var new_list = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(actions: [LogoutButton()]),
          body: BlocBuilder<Teacher_bloc, Teacher_state>(
              builder: (context, Teacher_state state) {
            if (state is TeacherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TeacherFailure) {
              return Center(
                child: Text('failed'),
              );
            }

            if (state is TeacherLoaded) {
              final teacher = state.teacher;
              return Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 50,
                        horizontal: 20,
                      ),
                      color: const Color.fromARGB(255, 232, 227, 214),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 84, 81, 71),
                            radius: 50,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 200,
                                height: 52,
                                child: ListTile(
                                  title: Text(state.teacher.name),
                                  leading: Icon(
                                    Icons.person,
                                    size: 25,
                                    semanticLabel: 'name',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     showModalBottomSheet(
                          //       context: context,
                          //       builder: (context) => PopUpProfile(
                          //         teacher: teacher,
                          //       ),
                          //     );
                          //   },
                          //   child: const Icon(
                          //     Icons.edit,
                          //     size: 25,
                          //     color: const Color.fromARGB(255, 84, 81, 71),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.teacher.sections.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(state.teacher.sections[index]),
                        subtitle:
                            const Text('Edit and view student\'s results'),
                        leading: const Icon(
                          Icons.school,
                          size: 25,
                          semanticLabel: 'section',
                        ),
                        hoverColor: const Color.fromARGB(255, 232, 227, 214),
                        onTap: () {
                          BlocProvider.of<MarklistBloc>(context).add(
                              GetSectionStudents(
                                  state.teacher.sections[index]));
                          // change it with go router
                          GoRouter.of(context).pushNamed(
                            "view students",
                            extra: state.teacher.sections[index],
                          );
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => FillMark(
                          //         section: state.teacher.sections[index]),
                          //   ),
                          // );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Text('app crashed!!'),
            );
          }),
        );
      }),
    );
  }
}
