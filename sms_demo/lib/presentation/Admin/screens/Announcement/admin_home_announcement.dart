import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_demo/presentation/auth/widgets/logout_button.dart';

class AdminAnnouncemntHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [LogoutButton()]),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Card(
                color: Color.fromARGB(123, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_open),
                    TextButton(
                      child: Text(
                        'Manage Announcemnt',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        GoRouter.of(context).pushNamed('admin announcement');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
