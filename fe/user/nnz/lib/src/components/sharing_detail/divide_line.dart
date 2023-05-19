import 'package:flutter/material.dart';

class DevideLine extends StatelessWidget {
  final Color bgColor;
  final double pad;

  const DevideLine({super.key, required this.bgColor, required this.pad});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: pad,
      ),
      child: Container(
        height: 2,
        width: double.maxFinite,
        color: bgColor,
      ),
    );
  }
}
