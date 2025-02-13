import 'package:flutter/material.dart';

class Cardbutton extends StatelessWidget {
  final String title;
  final IconData icon;

  const Cardbutton({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.all(6), // Adds spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
             blurStyle: BlurStyle.solid
          ),
        ],
      ),
      child: Center(
        
        child: Column(
          mainAxisSize: MainAxisSize.max, // Makes content centered
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
