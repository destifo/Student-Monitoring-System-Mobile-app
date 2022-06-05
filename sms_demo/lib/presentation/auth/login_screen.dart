import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Bloc/auth/auth_bloc.dart';
import 'package:sms_demo/Bloc/auth/auth_event.dart';
import 'package:sms_demo/Bloc/auth/auth_state.dart';
import 'package:sms_demo/Data/Teacher/data_provider/marklist/marklist_remote_provider.dart';
import 'package:sms_demo/Data/Teacher/data_repository/marklist_repository.dart';
import 'package:sms_demo/Data/admin/Management/data_provider/parent_provider/parent_api_provider.dart';
import 'package:sms_demo/Data/admin/Management/data_repository/ParentAccRepo/parent_repo.dart';
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';
import 'package:sms_demo/Domain/model/auth/user_response.dart';
import 'package:sms_demo/Domain/model/parent/student.dart';
import 'package:sms_demo/Domain/model/teacher/marklist.dart';

import '../Admin/screens/Grades/constants.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage("assets/login.jpg"),
              //         fit: BoxFit.fitHeight)),
              padding: EdgeInsets.only(top: 115),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 45),
                        child: Center(
                          child: Text(
                            "THE ELiTe Academy",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: usernameCtrl,
                            textAlign: TextAlign.center,
                            decoration: kinputdecoration.copyWith(
                                prefixIcon: Icon(Icons.verified_user),
                                labelText: "Username"),
                            validator: (username) {
                              if (username == null || username.isEmpty) {
                                return "Username must not be empty";
                              }
                              if (username.length < 6) {
                                return "password must be at least 6 charachters";
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            controller: passwordCtrl,
                            decoration: kinputdecoration.copyWith(
                                prefixIcon: Icon(Icons.lock),
                                labelText: "Password"),
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return "password must not be empty";
                              }
                              if (password.length < 6 || password.length > 10) {
                                return "password must be at least 6 charachters";
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                          builder: (_, AuthState state) {
                        Widget buttonText = const Text(
                          'Log in',
                          style: TextStyle(fontSize: 18),
                        );

                        if (state is LogingIn) {
                          buttonText = const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        // if (state is LoginSuccessful) {
                        //   buttonText = const Text("Login successful");
                        // }

                        if (state is LoginFailed) {
                          buttonText = const Text("Login failed");
                        }

                        return SizedBox(
                            child: ElevatedButton(
                                child: buttonText,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final AuthBloc authBloc =
                                        BlocProvider.of<AuthBloc>(context);
                                    authBloc.add(Login(
                                        usernameCtrl.text, passwordCtrl.text));
                                  }
                                }));
                      }, listener: (_, AuthState state) async {
                        if (state is LoginSuccessful) {
                          UserResponse response = state.response;
                          String role = response.role;
                          if (role == 'admin') {
                            GoRouter.of(_).goNamed('admin dashboard');
                          } else if (role == 'parent') {
                            final SharedPreferenceService prefService =
                                SharedPreferenceService();
                            final MarklistRepository markRepo =
                                MarklistRepository(MarklistRemoteProvider());
                            final ParentRepository parentRepo =
                                ParentRepository(
                                    parentProvider: ParentApiProvider());
                            var id = await prefService.getValueOf('id');
                            // print('passssssssssssedddddddd studnetttttttt');
                            List<Marklist> currStudentMark =
                                await markRepo.getStudentTotalGrade(id);
                            print('marrrrrrrrkkkkkkkkkkkklisttttttt');
                            ParentModel currStudent =
                                await parentRepo.getParrent(id);
                            Student student = Student(
                                studentName: currStudent.name,
                                className: currStudent.sectionName,
                                mark: currStudentMark.isEmpty
                                    ? [
                                        ['math', '0'],
                                        ['chemistry', '0'],
                                      ]
                                    : [
                                        ...(currStudentMark.map((e) {
                                          return [
                                            e.subjectName,
                                            (e.assesment +
                                                e.finalExam +
                                                e.midTerm +
                                                e.testOne +
                                                e.testTwo)
                                          ];
                                        }))
                                      ]);
                            GoRouter.of(_)
                                .goNamed('parent dashboard', extra: student);
                          } else if (role == 'teacher') {
                            GoRouter.of(_).goNamed('teacher homepage');
                          } else {
                            print('Unknown role found');
                          }
                        }
                      }),
                    ]),
              )),
        ),
      ),
    );
  }
}
