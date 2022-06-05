import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sms_demo/presentation/Admin/screens/Announcement/admin_home_announcement.dart';
import 'package:sms_demo/presentation/Admin/screens/Announcement/list_announcemnt.dart';
import 'package:sms_demo/presentation/Admin/screens/Grades/Sections_List.dart';
import 'package:sms_demo/presentation/Admin/screens/Grades/Students_List.dart';
import 'package:sms_demo/presentation/Admin/screens/home/home_page.dart';
import 'package:sms_demo/presentation/Admin/widgets/home/admin_nav_bar_drawer.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  String onTopOfDrawer = 'Parents';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomNavBarItem navItem(
      {required String title, required IconData icon}) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      title: (title),
      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      activeColorPrimary: Theme.of(context).primaryColor,
      inactiveColorPrimary: Colors.grey[300],
    );
  }

  SafeArea _buildScreen({required String title, required String body}) {
    return SafeArea(
      child: Text(body),
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(
        drawerKey: scaffoldKey,
        title: "Admin Home Page",
        body: "Access the drawer on top left to manage Users",
      ),
      AdminAnnouncemntHome(),
    ];
  }

  List<String> titles = ["Parents", "Announcement", "Grades"];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      navItem(title: 'Manage', icon: Icons.home_rounded),
      navItem(
        icon: Icons.message,
        title: 'Announcement',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: AdminNavBarDrawer(drawerKey: scaffoldKey),
      ),
      body: PersistentTabView(
        context,
        screens: _buildScreens(),
        backgroundColor: Colors.white,
        decoration: const NavBarDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            colorBehindNavBar: Colors.white,
            adjustScreenBottomPaddingOnCurve: false),
        onItemSelected: _onItemTapped,
        navBarStyle: NavBarStyle.simple,
        items: _navBarsItems(),
      ),
    );
  }
}
