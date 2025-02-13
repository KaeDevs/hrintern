import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Employeecharttab extends StatelessWidget {
  final String title;

  final Color? color;
  final IconData icon;
  Employeecharttab({super.key, required this.title, required this.icon, this.color}) ;
    // TODO: implement Employeechattab
    
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, ),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              "Total Employees - 1",
              style: TextStyle(color: color, fontSize: 14),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 1, // Active employees
                      color: color,
                      radius: 40,
                      title: '1',
                      titleStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.autorenew, color: color, size: 16),
                SizedBox(width: 4),
                Text("Active"),
                SizedBox(width: 16),
                Icon(Icons.autorenew, color: Colors.grey, size: 16),
                SizedBox(width: 4),
                Text("Leaving"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}