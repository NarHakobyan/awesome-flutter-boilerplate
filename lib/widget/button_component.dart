import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final List<Color> colors;
  final GestureTapCallback onTap;
  final Widget child;
  final double width;
  final double height;

  ButtonComponent({@required this.colors, this.onTap, this.width, this.height, @required this.child});

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.horizontal(left: Radius.circular(50), right: Radius.circular(50));
    return Container(
      width: width ?? 250,
      height: height ?? 50,
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            colors: colors,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Center(
              child: this.child,
            )),
      ),
    );
  }
}
