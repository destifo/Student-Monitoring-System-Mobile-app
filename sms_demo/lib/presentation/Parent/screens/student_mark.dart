import 'package:flutter/material.dart';

import '../../auth/widgets/logout_button.dart';

class StudentMark extends StatelessWidget {
  const StudentMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [LogoutButton()]),
      body: Container(
        child: const Text('Student Mark'),
      ),
    );
  }
}
