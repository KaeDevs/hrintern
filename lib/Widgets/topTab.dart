import 'package:flutter/material.dart';

class TopTab extends StatelessWidget {
  const TopTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.symmetric(
              vertical: BorderSide(width: 1, color: Colors.black),
              horizontal: BorderSide(width: 1, color: Colors.black))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [Icon(Icons.filter_alt), Text("Filters")],
        ),
      ),
    );
  }
}
