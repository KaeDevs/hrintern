import 'package:flutter/material.dart';

import 'package:flutter_intro/flutter_intro.dart';
import 'package:ss/Widgets/infoTab.dart';
import 'package:ss/Widgets/showRelaseNotesDialog.dart';
import 'package:ss/Widgets/smallTab.dart';
import 'package:ss/Widgets/topTab.dart';

class ViewAttendance extends StatelessWidget {
  final Key? key;

  ViewAttendance({
    this.key,
  });
  
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                          
                          // checkAndShowRN(context,  'va');
                        },
                        builder: (context, key) => TopTab(
                          key: key,
                        ),
                        order: 1,
                        padding: EdgeInsets.all(0),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 10, 0),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.widgets_rounded),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child:
                                              Icon(Icons.mode_comment_outlined),
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
                                                DataColumn(label: Text("Date")),
                                                DataColumn(
                                                    label: Text("Status")),
                                              ],
                                              rows: [
                                                DataRow(cells: [
                                                  DataCell(Text("16-Jun-2024")),
                                                  DataCell(Text("Present")),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(Text("15-Jun-2024")),
                                                  DataCell(Text("Present")),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(Text("14-Jun-2024")),
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
      ),
    );
  }
}
