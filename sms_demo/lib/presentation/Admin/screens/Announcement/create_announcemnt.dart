// ignore_for_file: prefer_const_constructors, unnecessary_this, prefer_null_aware_operators, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Bloc/admin_announcement_Bloc/blocs.dart';
import 'package:sms_demo/Domain/model/admin/Announcement/models.dart';

import '../../../auth/widgets/logout_button.dart';

class CreateAnnouncemnt extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  Announcemnt? announcemnt;
  CreateAnnouncemnt({this.announcemnt});
  final Map<String, dynamic> _announcemnt = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [LogoutButton()]),
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
                        padding: EdgeInsets.only(bottom: 25),
                        child: Center(
                          child: Text(
                            "Create New Announcemnt",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            initialValue: this.announcemnt == null
                                ? ""
                                : this.announcemnt?.title,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                labelText: 'Announcemnt Title'),
                            validator: (title) {
                              if (title == null || title.isEmpty) {
                                return "title must not be empty";
                              }
                            },
                            onSaved: (title) {
                              this._announcemnt['title'] = title;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            initialValue: this.announcemnt == null
                                ? ""
                                : this.announcemnt?.body,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            minLines: 5,
                            maxLines: 12,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              labelText: 'Announcemnt body',
                            ),
                            validator: (body) {
                              if (body == null || body.isEmpty) {
                                return "body must not be empty";
                              }
                            },
                            onSaved: (body) {
                              this._announcemnt['body'] = body;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          child: ElevatedButton(
                              child: Text(
                                "Create",
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                print('got here');
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  print('still here');
                                  print(_announcemnt);
                                  final AnnouncemntEvent event =
                                      announcemnt != null
                                          ? AnnouncemntUpdate(Announcemnt(
                                              title: this._announcemnt['title'],
                                              body: this._announcemnt['body'],
                                              id: this.announcemnt?.id))
                                          : AnnouncemntCreate(Announcemnt(
                                              title: this._announcemnt['title'],
                                              body: this._announcemnt['body'],
                                            ));
                                  print(event);
                                  BlocProvider.of<AnnouncemntBloc>(context)
                                      .add(event);
                                  GoRouter.of(context)
                                      .goNamed('admin announcement');
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ListAnnouncemnts()));
                                } else {
                                  print('error in the validation');
                                }
                              }))
                    ]),
              )),
        ),
      ),
    );
  }
}
