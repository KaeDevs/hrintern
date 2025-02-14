import 'dart:ui';

import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;

  DottedLinePainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Adjust control point dynamically
    double curveOffset = 50; // Increase for a bigger arc

    Offset control = Offset(
      (start.dx + end.dx) , // Midpoint X
      (start.dy + end.dy) / 2 - curveOffset, // Midpoint Y (raise for arc)
    );

    // If the button is on the right side, adjust curve inward
    if (start.dx > end.dx) {
      control = Offset(
        (start.dx + end.dx)- 400 ,
        (start.dy + end.dy) /2, // Flip curve downward
      );
    }

    final Path path = Path()
      ..moveTo(start.dx, start.dy)
      
      ..quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);

    final double dashLength = 5, dashSpace = 5;
    double distance = 0;
    final PathMetric pathMetric = path.computeMetrics().first;
    final double pathLength = pathMetric.length;

    while (distance < pathLength) {
      final double nextDistance = distance + dashLength;
      canvas.drawLine(
        pathMetric.getTangentForOffset(distance)!.position,
        pathMetric
            .getTangentForOffset(
                nextDistance < pathLength ? nextDistance : pathLength)!
            .position,
        paint,
      );
      distance += dashLength + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}