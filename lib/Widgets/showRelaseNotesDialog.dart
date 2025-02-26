import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:ss/Widgets/EmployeeChartTab.dart';
import 'package:ss/Widgets/attendanceCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss/Widgets/EmployeeChartTab.dart';
import 'package:ss/Widgets/attendanceCard.dart';
import 'package:ss/controllers/basic_controller.dart';

class ReleaseNotesDialog extends StatelessWidget {
  MyController noteController =
      Get.put(MyController(), tag: "r_n", permanent: false);

  Widget nowContent(int tipNo) {
    switch (tipNo) {
      case 1:
        return content_release_notes(
            headline: "What's New", info: "Welcome to the newly updated app");
      case 2:
        return content_release_notes(
            headline: "All your Attendance on fingertips",
            info: "Single view and access to all your Employee's attendance");
      case 3:
        return content_release_notes(
            headline: "Quick View of Percentages",
            info: "Graphical visualization of your data");
      default:
        return content_release_notes(
            headline: "All your accounts on fingertips",
            info: "Single view and access to all your accounts and balances");
    }
  }

  Widget topContent(int tipNo) {
    switch (tipNo) {
      case 1:
        return SizedBox(height: 0);
      case 2:
        return SizedBox(
          height: 300,
          width: 500  ,
          child: attendanceCard(
              title: "Today Attendance", icon: Icons.calendar_month_sharp),
        );
      case 3:
        return SizedBox(
          height: 300,
          width: 350 ,
          child : Employeecharttab(
          title: "Employees",
          icon: Icons.person,
          color: Colors.green,
        ));
      default:
        return Icon(Icons.abc, color: Colors.amber, size: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.transparent,
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() =>
              topContent(noteController.tip_no.value)), // Observing tip_no
          SizedBox(height: 20),
          IntrinsicWidth(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PopScope(
                  onPopInvokedWithResult: (context, value) async {
                    Get.delete<MyController>(
                        tag: "r_n"); // Remove controller when dialog closes
                    return;
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 209, 209, 209),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.lightbulb_outline),
                                  Obx(() => Text(
                                      "Quick Tip ${noteController.tip_no.value}/${noteController.max_pages}")),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => nowContent(noteController.tip_no.value)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => noteController.tip_no.value == 1
                              ? TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Skip",
                                      style: TextStyle(fontSize: 16)),
                                )
                              : TextButton(
                                  onPressed: noteController.decreaseTipNo,
                                  child: Text("Previous",
                                      style: TextStyle(fontSize: 16)),
                                )),
                          TextButton(
                                  onPressed: (){_showMyDialog(context);},
                                  child: Text("Alert Dialog",
                                      style: TextStyle(fontSize: 16)),
                                ),
                          Obx(() => noteController.tip_no.value ==
                                  noteController.max_pages.value
                              ? TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Finish",
                                      style: TextStyle(fontSize: 16)),
                                )
                              : TextButton(
                                  onPressed: noteController.increaseTipNo,
                                  child: Text("Next",
                                      style: TextStyle(fontSize: 16)),
                                ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for displaying release note content
class content_release_notes extends StatelessWidget {
  final String headline;
  final String info;

  const content_release_notes({required this.headline, required this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(headline,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(info, style: TextStyle(fontSize: 16), textAlign: TextAlign.start),
      ],
    );
  }
}

Future<void> showReleaseNotesDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReleaseNotesDialog();
    },
  );
}

void checkAndShowRN(BuildContext context, String grp) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasShownRN = prefs.getBool('hasShownRN') ?? false;

  if (!hasShownRN) {
    if (grp != '') {
      Intro.of(context).start(group: grp, reset: true);
      return;
    } else {
      await showReleaseNotesDialog(context);
      Intro.of(context).start(reset: true);
    }
    await prefs.setBool("hasShownRN", true);
  }
}

class content_realease_notes extends StatelessWidget {
  String? Headline;
  String? info;

  content_realease_notes({this.Headline, this.info});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Headline!,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          info!,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}


Future<void> _showMyDialog(BuildContext context) async {
  
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog '),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a alert dialog.'),
              // Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              // Navigator.of(context).pop();
              Get.back();
            },
          ),
        ],
      );
    },
  );
}