import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class smallTab extends StatelessWidget {
  final String? Title;
  final IconData? icon;
  final Color? color;
  final int? num;

  const smallTab({super.key, this.Title, this.icon, this.color, this.num});

  @override
  Widget build(BuildContext context) {
    Color lighterColor = Color.lerp(color, Colors.white, 0.5)!;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: PhysicalModel(
        color: Colors.transparent,
        shadowColor: Colors.black54,
        elevation: 3,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 160,
          height: 100,
          decoration: BoxDecoration(
              color: lighterColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                // BoxShadow(
                //     color: const Color.fromARGB(255, 88, 88, 88)
                //         .withValues(alpha: 20),
                //     offset: Offset(1, 2),
                //     spreadRadius: 1,
                //     blurRadius: 3)
              ]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: color),
                    SizedBox(width: 5),
                    Text(
                      "$Title",
                      style: TextStyle(
                        fontFamily: "H1",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$num",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
