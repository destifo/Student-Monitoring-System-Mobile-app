import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../auth/widgets/logout_button.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  final String title;
  final String body;
  const HomePage(
      {Key? key,
      required this.drawerKey,
      required this.title,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        actions: [LogoutButton()],
        leading: InkWell(
          onTap: () {
            drawerKey.currentState!.openDrawer();
          },
          child: const Icon(Icons.menu),
        ),
      ),
      body: Center(
        child: Text(body),
      ),
    );
  }
}
