import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/propose_controller.dart';

class ProposeBtn extends StatelessWidget {
  ProposeBtn({super.key});
  final controller = Get.put(ProposeController());
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
          GestureDetector(
            onTap: () {
              controller.onReqShow();
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
