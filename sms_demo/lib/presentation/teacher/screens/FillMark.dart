import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_demo/Bloc/marklist_bloc/marklist_bloc.dart';
import 'package:sms_demo/presentation/teacher/screens/PopUpMarlist.dart';

import '../../auth/widgets/logout_button.dart';

class FillMark extends StatelessWidget {
  FillMark({Key? key, required this.section}) : super(key: key);
  final section;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarklistBloc, MarklistState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is StudentsReturned) {
          return Scaffold(
            appBar: AppBar(actions: [LogoutButton()]),
            body: ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 15,
                ),
                title: Text(state.students[index].name),
                hoverColor: const Color.fromARGB(255, 232, 227, 214),
                trailing: GestureDetector(
                    onTap: () {
                      BlocProvider.of<MarklistBloc>(context)
                          .add(GetStudentMark(state.students[index].id!));
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => PopUpMarklist(
                          id: state.students[index].id!,
                        ),
                      );
                    },
                    child: const Icon(Icons.add)),
                onTap: () {
                  BlocProvider.of<MarklistBloc>(context)
                      .add(GetStudentMark(state.students[index].id!));
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) =>
                        PopUpMarklist(id: state.students[index].id!),
                  );
                },
              ),
            ),
          );
        }
        return Text("");
      },
    );
  }
}
