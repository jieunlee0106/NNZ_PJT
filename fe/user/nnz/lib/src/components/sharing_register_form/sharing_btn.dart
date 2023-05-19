import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

import '../../config/config.dart';

class SharingBtn extends StatelessWidget {
  SharingBtn({super.key});
  final controller = Get.put(SharingRegisterController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {
          controller.onShareRegister();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Config.yellowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Text(
            "등록하기",
            style: TextStyle(
              fontSize: 16,
              color: Config.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
