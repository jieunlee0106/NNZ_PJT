import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrayLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        height: 10,
        color: Color.fromARGB(255, 237, 237, 237));
  }
}
