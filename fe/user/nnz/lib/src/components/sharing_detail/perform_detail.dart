import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';

class PerformDetail extends StatelessWidget {
  const PerformDetail(
      {super.key,
      required this.performTitle,
      required this.iconName,
      required this.textSize});

  final String performTitle;
  final IconData iconName;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Icon(
            iconName,
            color: const Color(0xFFF3C906),
            size: textSize + 10,
          ),
          Container(
            width: 6,
          ),
          Text(
            performTitle,
            style: TextStyle(color: Config.blackColor, fontSize: textSize),
          )
        ],
      ),
    );
  }
}
