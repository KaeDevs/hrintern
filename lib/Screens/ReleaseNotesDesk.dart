import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:ss/Tools/CustomAppBar.dart';
import 'package:ss/Widgets/showRelaseNotesDialog.dart';

class Releasenotesdesk extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(scaffoldKey: scaffoldKey),
            body: Row(children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
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
                        Get.back();
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
                        // await showReleaseNotesDialog(context);
                      },
                    ),
                    ListTile(
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      leading: Icon(Icons.no_encryption_gmailerrorred_outlined),
                      title: Text("PlaceHolder"),
                      onTap: () async {
                        // Navigator.pop(context);
                        // Intro.of(context).start(reset: true, group: 'va');
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

                        // Intro.of(context).start(reset: true, group: 'va');
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
                ),
              ),
              Flexible(
                flex: 4,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        await showReleaseNotesDialog(context);
                      },
                      child: Text("Open Release Notes")),
                ),
              )
            ])));
  }
}
