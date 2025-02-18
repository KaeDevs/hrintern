import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:ss/BaseOfAppDesk.dart';
import 'package:ss/Screens/viewAttendanceDesk.dart';
import 'package:ss/Widgets/EmployeeChartTab.dart';
import 'package:ss/Widgets/attendanceCard.dart';
import 'package:ss/Widgets/cardButton.dart';
import 'package:ss/Widgets/showRelaseNotesDialog.dart';

class HomepageDesk extends StatefulWidget {
  @override
  State<HomepageDesk> createState() => _HomepageDeskState();
}

class _HomepageDeskState extends State<HomepageDesk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 64, 116)),
                child: Container(
              
              color: const Color.fromARGB(255, 1, 0, 71),
                            
              width: MediaQuery.of(context).size.width / 2,
              child: ListView(padding: EdgeInsets.zero, children: [
                // DrawerHeader(
                //   // decoration: BoxDecoration(color: Colors.blue),
                //   child: Text(
                //     "My Drawer",
                //     style: TextStyle(color: Colors.white, fontSize: 24),
                //   ),
                // ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
    Get.to(() =>ViewAttendanceDesk());
    // Navigator.pop(context);
    
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.note_add_sharp),
                  title: Text("Release Notes"),
                  onTap: () async {
    // Navigator.pop(context);
    await showReleaseNotesDialog(context);
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.no_encryption_gmailerrorred_outlined),
                  title: Text("PlaceHolder"),
                  onTap: () async {
    // Navigator.pop(context);
    Intro.of(context).start(reset: true);
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.tungsten_outlined),
                  title: Text("Tutoral"),
                  onTap: () async {
    // Navigator.pop(context);
    print("clickedddd");
    setState(() {
    Intro.of(context).start(reset: true);
  });
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {
    // Navigator.pop(context);
                  },
                ),
              ]),
            ), // Pass context here
              ),
            ),
            Flexible(
              flex: 4,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      attendanceCard(
                        title: "Today attendance",
                        icon: Icons.calendar_month,
                      ),
                      SizedBox(height: 0),
                      Employeecharttab(
                        title: "Employees",
                        icon: Icons.person,
                        color: Colors.green,
                      ),
                      Employeecharttab(
                        title: "Attendance",
                        icon: Icons.person,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class NewWidget extends StatelessWidget {

  BuildContext? intcontext ;
  NewWidget({
    super.key, this.intcontext
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
              
              backgroundColor: const Color.fromARGB(255, 1, 0, 71),
              elevation: 5,
              
              width: MediaQuery.of(context).size.width / 2,
              child: ListView(padding: EdgeInsets.zero, children: [
                // DrawerHeader(
                //   // decoration: BoxDecoration(color: Colors.blue),
                //   child: Text(
                //     "My Drawer",
                //     style: TextStyle(color: Colors.white, fontSize: 24),
                //   ),
                // ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
    Get.to(() =>ViewAttendanceDesk());
    // Navigator.pop(context);
    
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.note_add_sharp),
                  title: Text("Release Notes"),
                  onTap: () async {
    // Navigator.pop(context);
    await showReleaseNotesDialog(context);
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.no_encryption_gmailerrorred_outlined),
                  title: Text("PlaceHolder"),
                  onTap: () async {
    // Navigator.pop(context);
    Intro.of(intcontext!).start(reset: true);
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.tungsten_outlined),
                  title: Text("Tutoral"),
                  onTap: () async {
    // Navigator.pop(context);
    print("clickedddd");
    Intro.of(context).start(reset: true);
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {
    // Navigator.pop(context);
                  },
                ),
              ]),
            );
  }
}
