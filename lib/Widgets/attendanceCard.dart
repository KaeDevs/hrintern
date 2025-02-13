import 'package:flutter/material.dart';

class attendanceCard extends StatelessWidget {
  final String title;
  final IconData icon;

  attendanceCard({super.key, required this.title, required this.icon});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      icon,
                      size: 20,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 0),
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 70),
                  ],
                ),
                    DataTable(columns: [
                      DataColumn(label: Text("Status")),
                      DataColumn(label: Text("First in")),
                      DataColumn(label: Text("last out")),
                    ], rows: [
                      DataRow(cells: [DataCell(Text("Absent")),DataCell(Text("Absent")),DataCell(Text("Absent")) ])
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
