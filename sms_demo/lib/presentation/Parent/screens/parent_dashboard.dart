import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sms_demo/Data/Teacher/data_provider/marklist/marklist_remote_provider.dart';
import 'package:sms_demo/Data/Teacher/data_repository/marklist_repository.dart';
import 'package:sms_demo/Data/admin/Management/data_provider/parent_provider/parent_api_provider.dart';
import 'package:sms_demo/Data/admin/Management/data_repository/ParentAccRepo/parent_repo.dart';
import 'package:sms_demo/Data/local/shared_preferences/shared_preference_service.dart';
import 'package:sms_demo/Domain/model/admin/Management/student_model.dart';
import 'package:sms_demo/Domain/model/parent/student.dart';
import 'package:sms_demo/Domain/model/teacher/marklist.dart';
import 'package:sms_demo/presentation/Parent/screens/Announcement/screens.dart';
import 'package:sms_demo/presentation/Parent/screens/student_info.dart';
import 'home_page2.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({Key? key, required this.student}) : super(key: key);
  final Student student;

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  int _selectedIndex = 0;
  // late List<Marklist> studentMark;
  // late ParentModel student;
  String onTopOfDrawer = 'Parents';
  final SharedPreferenceService prefService = SharedPreferenceService();

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
      StudentInfo(
        student: widget.student,
      ),
      ListAnnouncemntsParent(),
    ];
  }

  List<String> titles = ["Parents", "Announcement", "Grades"];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      navItem(title: 'Student Information', icon: Icons.home_rounded),
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
