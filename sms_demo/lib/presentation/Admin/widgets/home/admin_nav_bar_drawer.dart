import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/smy_home_page.dart';
import 'package:sms_demo/presentation/Admin/screens/Management/teacher_page.dart';
import 'package:sms_demo/presentation/Admin/screens/home/home_page.dart';

class AdminNavBarDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  const AdminNavBarDrawer({Key? key, required this.drawerKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Center(
            child: Row(
              children: [
                const Expanded(
                  child: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    "Admin",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  flex: 6,
                ),
              ],
            ),
          )),
      ListTile(
        title: const Text("Parents"),
        leading: const Icon(Icons.person_rounded),
        onTap: () {
          // pushNewScreen(context, withNavBar: true, screen: const MyHomePage());
          GoRouter.of(context).pushNamed('manage parents');
          // Navigator.of(context).pop();
        },
      ),
      const Divider(
        color: Colors.grey,
      ),
      ListTile(
        title: const Text("Teachers"),
        leading: const Icon(
          // onPressed: () {
          //   Navigator.of(context).pop();
          // },
          Icons.person_pin_rounded,
        ),
        onTap: () {
          // pushNewScreen(
          //   context,
          //   screen: const TeacherPage(),
          //   withNavBar: true,
          // );
          GoRouter.of(context).pushNamed('manage teachers');
        },
      ),
    ]);
  }
}
