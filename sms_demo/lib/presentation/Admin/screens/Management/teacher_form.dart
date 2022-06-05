import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/teacher_page.dart';

import '../../../../Bloc/TeacherAccountManagement/TeacherAccBloc.dart';
import '../../../../Bloc/TeacherAccountManagement/TeacherAccEvent.dart';
import '../../../../Bloc/TeacherAccountManagement/TeacherAccState.dart';
import '../../../../Domain/model/admin/Management/teacher_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/widgets/logout_button.dart';

class TeacherForm extends StatefulWidget {
  TeacherModel? teacher;
  int status;
  TeacherForm({Key? key, required this.status, this.teacher}) : super(key: key);

  @override
  State<TeacherForm> createState() => _TeacherFormState();
}

class _TeacherFormState extends State<TeacherForm> {
  String? id = '';
  TextEditingController name = TextEditingController();
  bool gender = true;
  var sections = ['', '', '', '', ''];
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController subjectName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  

  @override
  void initState() {
    var teacher = widget.teacher;
    if (widget.teacher != null) {
      List<String> asections = [];
      var length = teacher!.sections.length;

      for (int i = 0; i < 5; i++) {
        if (i <= length) {
          asections.add(teacher.sections[i].toString());
        } else {
          asections.add("");
        }
      }
      print(asections);
      id = teacher.id;
      gender = teacher.gender == "male" ? true : false;
      name.text = teacher.name;
      username.text = teacher.username;
      sections = asections;
      password.text = "";
      subjectName.text = teacher.subjectName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit teacher Information"),
          actions: [LogoutButton()]
        ),
        body: Center(
          child: Container(
            width: 350,
            decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            child: Form(
                key: _formKey,
                child: Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        SizedBox(width: 280, child: nameBuilder()),
                        SizedBox(width: 280, child: sectionBuilder(0)),
                        SizedBox(width: 280, child: sectionBuilder(1)),
                        SizedBox(width: 280, child: sectionBuilder(2)),
                        SizedBox(width: 280, child: sectionBuilder(3)),
                        SizedBox(width: 280, child: sectionBuilder(4)),
                        SizedBox(width: 280, child: subjectBuilder()),
                        SizedBox(width: 280, child: passwordBuilder()),
                        SizedBox(
                          width: 280,
                          child: usernameBuilder(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        genderBuilder(),
                        submitButton(),
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }

  Widget nameBuilder() {
    return TextFormField(
      controller: name,
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 5) {
          return "Please enter some valid text";
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: "Name *",
      ),
      keyboardType: TextInputType.name,
    );
  }

  Widget subjectBuilder() {
    return TextFormField(
      controller: subjectName,
      validator: (value) {
        value = value.toString().toLowerCase();
        if (value == null || value.isEmpty || value.length < 4) {
          if (value != "history" ||
              value != "physics" ||
              value != "chemistry" ||
              value != "geography" ||
              value != "math" ||
              value != "ict" ||
              value != "hpe" ||
              value != "biology" ||
              value != "amharic" ||
              value != "aptitude" ||
              value != "civics" ||
              value != "civics" ||
              value != "bussiness" ||
              value != "economics") {
            return "Please enter some valid text";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.book),
        labelText: "Subject *",
      ),
      keyboardType: TextInputType.name,
    );
  }

  Widget usernameBuilder() {
    return TextFormField(
      controller: username,
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 5) {
          return "Please enter some valid username";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "username *",
      ),
    );
  }

  Widget passwordBuilder() {
    return TextFormField(
      controller: password,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 5) {
          return "Please enter some valid password";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "password *",
      ),
    );
  }

  Widget sectionBuilder(index) {
    return TextFormField(
      initialValue: sections[index],
      onSaved: (value) {
        sections[index] = value.toString();
      },
      validator: (value) {
        if (value == null || value.length > 3) {
          return "Please enter some valid section number";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Section *", hintText: "If none leave it empty"),
    );
  }

  Widget genderBuilder() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ChoiceChip(
        label: Text("Male"),
        selected: gender == true,
        onSelected: (_) {
          gender = true;
        },
      ),
      SizedBox(
        width: 20,
      ),
      ChoiceChip(
        label: Text("Female"),
        selected: gender == false,
        onSelected: (_) {
          gender = false;
        },
      )
    ]);
  }

  Widget submitButton() {
    return TextButton(
        child: Text("submit"),
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          } else {
            var sec = [];
            for (var section in sections) {
              if (section != "") {
                sec.add(section);
              }
            }
            _formKey.currentState!.save();
            if (widget.status == 1) {
              BlocProvider.of<TeacherAccBloc>(context).add(AddTeacherAcc(
                  name: name.text,
                  gender: gender == true ? "male" : "female",
                  sections: sections,
                  subjectName: subjectName.text.toLowerCase().trim(),
                  password: password.text,
                  username: username.text));
            } else {
              BlocProvider.of<TeacherAccBloc>(context).add(UpdateTeacherAcc(
                  id: widget.teacher!.id!,
                  teacher: TeacherModel(
                      name: name.text,
                      gender: gender == true ? "male" : "female",
                      sections: sections,
                      subjectName: subjectName.text.toLowerCase().trim(),
                      password: password.text,
                      username: username.text)));
            }
            GoRouter.of(context).goNamed('manage teachers');
          }
        });
  }
}
