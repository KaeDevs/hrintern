import 'package:flutter/material.dart';

import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:ss/BaseOfAppDesk.dart';
import 'package:ss/Tools/CustomAppBar.dart';
import 'package:ss/Tools/DottedCurve.dart';
import 'package:ss/Widgets/infoTab.dart';
import 'package:ss/Widgets/showRelaseNotesDialog.dart';
import 'package:ss/Widgets/smallTab.dart';
import 'package:ss/Widgets/topTab.dart';

class ViewAttendanceDesk extends StatelessWidget {
  // final Key? key;

  // ViewAttendance({
  //   // this.key,
  // });
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(scaffoldKey: scaffoldKey),
        body: Row(
          children: [
            Container(
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
                    // Get.to(() =>ViewAttendanceDesk());
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
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Employee Attendance ℹ",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "H1",
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          IntroStepBuilder(
                            text: "You can Filter details using this button",
                            group: 'va',
                            onWidgetLoad: () {
                              // Intro.of(context).start(group: 'va');
                              checkAndShowRN(context, 'va');
                            },
                            builder: (context, key) => TopTab(
                              key: key,
                            ),
                            order: 1,
                            padding: EdgeInsets.all(0),
                            getOverlayPosition: ({
                              required Offset offset,
                              required Size screenSize,
                              required Size size,
                            }) {
                              return OverlayPosition(
                                top: size.height + offset.dy,
                                width: screenSize.width,
                                crossAxisAlignment: CrossAxisAlignment.end,
                              );
                            },
                            overlayBuilder: (params) {
                              return Stack(
                                children: [
                                  // Background Color
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      color: Colors
                                          .transparent // Semi-transparent overlay
                                      ),
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: DottedLinePainter(
                                        start: Offset(
                                            params.offset!.dx +
                                                params.size.width / 2,
                                            params.offset!.dy - 58),
                                        end: Offset(
                                            MediaQuery.of(context).size.width /
                                                2,
                                            MediaQuery.of(context).size.height *
                                                0.43),
                                        // curve: Offset(
                                        //     params.offset!.dx +
                                        //         params.size.width / 2 +
                                        //         20 +
                                        //         MediaQuery.of(context).size.width / 2,
                                        //     (params.offset!.dy -
                                        //                 35 +
                                        //                 MediaQuery.of(context).size.height *
                                        //                     0.43) /
                                        //             2 -
                                        //         50)
                                      ),
                                    ),
                                  ),
                                  // Centered Content
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24), // Add padding
                                        child: Column(
                                          mainAxisSize: MainAxisSize
                                              .max, // Shrink to fit content
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Center horizontally
                                          children: [
                                            // Text in the center
                                            Text(
                                              "You can Filter the results using this Button!",
                                              textAlign: TextAlign
                                                  .center, // Center text
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    20), // Spacing between text and button

                                            // Next Button (Properly Styled)
                                            IntroButton(
                                              fontSize: 17,
                                              text: "Finish",
                                              onPressed: params
                                                  .onFinish, // Call function properly
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(255, 0,
                                                        0, 0), // Button color
                                                foregroundColor:
                                                    Colors.teal, // Text color
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                    vertical: 12),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // Rounded corners
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: PhysicalModel(
                              shadowColor: Colors.black,
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              elevation: 2,
                              child: infoTab(),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 10, 0),
                                        child: Text(
                                          "Your Stats Count Here ",
                                          style: TextStyle(
                                              fontFamily: "H1",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Icon(Icons.where_to_vote_outlined)
                                    ],
                                  ),
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 9,
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                child: smallTab(
                                                    Title: "Present",
                                                    icon: Icons.check_box,
                                                    color: Colors.green,
                                                    num: 4),
                                              ),
                                              SizedBox(
                                                child: smallTab(
                                                    Title: "Absent",
                                                    icon: Icons.close,
                                                    color: Colors.red,
                                                    num: 2),
                                              ),
                                              SizedBox(
                                                child: smallTab(
                                                    Title: "Late",
                                                    icon: Icons.access_time,
                                                    color: Colors.orange,
                                                    num: 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(Icons.widgets_rounded),
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Icon(
                                                  Icons.mode_comment_outlined),
                                            ),
                                          ],
                                        ),
                                        SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: [
                                              SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: DataTable(
                                                  border: TableBorder.all(
                                                      color: Colors.black),
                                                  columns: [
                                                    DataColumn(
                                                        label: Text("Date")),
                                                    DataColumn(
                                                        label: Text("Status")),
                                                  ],
                                                  rows: [
                                                    DataRow(cells: [
                                                      DataCell(
                                                          Text("16-Jun-2024")),
                                                      DataCell(Text("Present")),
                                                    ]),
                                                    DataRow(cells: [
                                                      DataCell(
                                                          Text("15-Jun-2024")),
                                                      DataCell(Text("Present")),
                                                    ]),
                                                    DataRow(cells: [
                                                      DataCell(
                                                          Text("14-Jun-2024")),
                                                      DataCell(Text("Absent")),
                                                    ]),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
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
