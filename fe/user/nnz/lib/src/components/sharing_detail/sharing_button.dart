import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';

class SharingButton extends StatelessWidget {
  final double btnheight;
  final double btnwidth;
  final String btntext;

  const SharingButton({
    super.key,
    required this.btnheight,
    required this.btnwidth,
    required this.btntext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Config.yellowColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: btnwidth, vertical: btnheight),
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 12,
              color: Config.blackColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
