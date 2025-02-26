import 'package:flutter/material.dart';

class attendanceCardDesk extends StatelessWidget {
  final String title;
  final IconData icon;

  attendanceCardDesk({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: PhysicalModel(
        
        color : Colors.transparent,
        // shadowColor: Colors.black,
        elevation: 1,
        
        borderRadius: BorderRadius.circular(5),
        child: Container(
          
          // margin: EdgeInsets.all(10), // Adds spacing
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.black12,
            //       blurRadius: 5,
            //       spreadRadius: 1,
            //       blurStyle: BlurStyle.solid),
            // ],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 20,),
                      Text(
                        title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 70),
                    ],
                  ),
                ),
                    DataTable(
                      columnSpacing: 140,

                      columns: [
                      DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.w900),)),
                      DataColumn(label: Text("First in",style: TextStyle(fontWeight: FontWeight.w900))),
                      DataColumn(label: Text("last out",style: TextStyle(fontWeight: FontWeight.w900))),
                      DataColumn(label: Text("Shift in",style: TextStyle(fontWeight: FontWeight.w900))),
                      DataColumn(label: Text("Shift out",style: TextStyle(fontWeight: FontWeight.w900))),
                    ], rows: [
                      DataRow(cells: [DataCell(Text("Absent")),DataCell(Text("Absent")),DataCell(Text("Absent")),DataCell(Text("--")),DataCell(Text("--")) ])
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
