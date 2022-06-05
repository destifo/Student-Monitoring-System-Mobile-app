// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/Bloc/admin_announcement_Bloc/announcemnt_bloc.dart';
import 'package:sms_demo/Bloc/admin_announcement_Bloc/blocs.dart';
import 'package:sms_demo/presentation/Admin/screens/Announcement/create_announcemnt.dart';

import '../../../auth/widgets/logout_button.dart';

class ListAnnouncemnts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcemnts'),
        actions: [LogoutButton()]
      ),
      body: BlocBuilder<AnnouncemntBloc, AnnouncemntState>(
        builder: (context, state) {
          if (state is AnnouncemntOperationFailure) {
            return Text('Couldn\'t find any announcemnts');
          }
          if (state is AnnouncemntLoadSuccess) {
            final announcemnts = state.announcemnts;
            return Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 30,
                top: 10,
              ),
              child: ListView.builder(
                itemCount: announcemnts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: 10,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 118, 129, 179),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                announcemnts[index].title,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          announcemnts[index].body,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: SizedBox(
                              width: double.infinity,
                            )),
                            Text(
                              announcemnts[index]
                                  .createTime
                                  .toString()
                                  .split(" ")[0],
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit_note,
                            ),
                            onPressed: () {
                              GoRouter.of(context).pushNamed('edit announcement', extra: announcemnts[index]);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => BlocProvider.value(
                              //         value: BlocProvider.of<AnnouncemntBloc>(
                              //             context),
                              //         child: CreateAnnouncemnt(
                              //           announcemnt: announcemnts[index],
                              //         ))));
                            },
                            hoverColor: Colors.white,
                            iconSize: 35,
                            tooltip: 'Edit',
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {
                              BlocProvider.of<AnnouncemntBloc>(context)
                                  .add(AnnouncemntDelete(announcemnts[index]));
                            },
                            hoverColor: Colors.white,
                            tooltip: 'delete',
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                            ),
                          ),
                        ])
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed('create announcement');
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => CreateAnnouncemnt()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
