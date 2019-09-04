import 'package:flutter/material.dart';

class GreenClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path()..lineTo(0, size.height - 100);

    final Offset firstControlPoint = Offset(size.width / 2, size.height);
    final Offset firstEndPoint = Offset(size.width, size.height - 100);

    return path
      ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
