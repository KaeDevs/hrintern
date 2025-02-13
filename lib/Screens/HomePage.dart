import 'package:flutter/material.dart';
import 'package:ss/Widgets/EmployeeChartTab.dart';
import 'package:ss/Widgets/attendanceCard.dart';
import 'package:ss/Widgets/cardButton.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Adds spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Buttons row (Now scrolls)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/page2');
                        },
                        child: Cardbutton(
                          title: "View Attendance",
                          icon: Icons.people_rounded,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Cardbutton(
                          title: "Face Attendance",
                          icon: Icons.face_retouching_natural_sharp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 0), // Space between row and cards

                // Scrollable Content
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
    );
  }
}
