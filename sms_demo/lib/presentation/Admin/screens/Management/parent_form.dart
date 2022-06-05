import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Bloc/ParentAccountManagement/ParAccBloc.dart';
import 'package:sms_demo/Bloc/ParentAccountManagement/ParAccEvent.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/smy_home_page.dart';

import '../../../../Bloc/ParentAccountManagement/ParrAccState.dart';
import '../../../auth/widgets/logout_button.dart';

class ParentForm extends StatefulWidget {
  ParentModel? parent;
  int status;
  ParentForm({Key? key, required this.status, this.parent}) : super(key: key);

  @override
  State<ParentForm> createState() => _ParentFormState();
}

class _ParentFormState extends State<ParentForm> {
  String? id = '';
  TextEditingController name = TextEditingController();
  bool gender = true;
  TextEditingController sectionName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    var parent = widget.parent;
    if (widget.parent != null) {
      id = parent!.id;
      gender = parent.gender == "male" ? true : false;
      name.text = parent.name;
      username.text = parent.username;
      sectionName.text = parent.sectionName;
      password.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit parent Information"),
          actions: [LogoutButton()]
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 350,
              height: 400,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //ListView(children: [
                      SizedBox(width: 280, child: nameBuilder()),
                      SizedBox(width: 280, child: passwordBuilder()),
                      SizedBox(width: 280, child: sectionBuilder()),
                      SizedBox(
                        width: 280,
                        child: usernameBuilder(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      genderBuilder(),
                      submitButton(),
                      //])
                    ],
                  )),
            ),
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
        labelText: "Username *",
      ),
    );
  }

  Widget passwordBuilder() {
    return TextFormField(
      obscureText: true,
      controller: password,
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

  Widget sectionBuilder() {
    return TextFormField(
      controller: sectionName,
      validator: (value) {
        if (value == null || value.length > 3) {
          return "Please enter some valid section number";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Section *",
      ),
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
            if (widget.status == 1) {
              BlocProvider.of<ParAccBloc>(context).add(AddParAcc(
                  name: name.text,
                  gender: gender == true ? "male" : "female",
                  sectionName: sectionName.text,
                  password: password.text,
                  username: username.text));
            } else {
               BlocProvider.of<ParAccBloc>(context).add(UpdateParAcc(
                  id: widget.parent!.id!,
                  parent: ParentModel(
                      name: name.text,
                      gender: gender == true ? "male" : "female",
                      sectionName: sectionName.text,
                      password: password.text,
                      username: username.text)));
            }

            GoRouter.of(context).goNamed('manage parents');
          }
        });
  }
}
