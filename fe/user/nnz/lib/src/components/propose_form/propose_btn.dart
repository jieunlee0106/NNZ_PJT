import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';

class ProposeBtn extends StatelessWidget {
  const ProposeBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 16,
        bottom: Get.width * 0.6,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Config.yellowColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "보내기",
              style: TextStyle(
                color: Config.blackColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
