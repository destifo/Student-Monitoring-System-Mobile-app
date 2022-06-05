import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Bloc/ParentAccountManagement/ParAccEvent.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/parent_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/ParentAccountManagement/ParAccBloc.dart';
import '../../../../Bloc/ParentAccountManagement/ParrAccState.dart';
import '../../../auth/widgets/logout_button.dart';
import 'parent.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    BlocProvider.of<ParAccBloc>(context).add(LoadParAccs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Parent"), actions: [LogoutButton()]),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            GoRouter.of(context).pushNamed('add parent');
          },
        ),
        body: BlocBuilder<ParAccBloc, ParrAccState>(
          builder: (context, state) {
            if (state is ParentsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ParentsLoadingFailed) {
              return Text("some error");
            }
            if (state is ParentsLoaded) {
              return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                              itemCount: state.parents.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 5,
                                );
                              },
                              itemBuilder: (context, index) {
                                return Parent(parent: state.parents[index]);
                              }))
                    ],
                  ));
            }
            return const Text("");
          },
        ));
  }
}
