import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/find_password_controller.dart';

class FindPasswordBtn extends StatelessWidget {
  FindPasswordBtn({super.key});
  final controller = Get.put(FindPasswordController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.onFindPassword();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: controller.findPwdChecked.value
                ? Config.yellowColor
                : Config.greyColor,
          ),
          child: Center(
            child: Text(
              "비밀번호 변경",
              style: TextStyle(
                color: controller.findPwdChecked.value
                    ? Config.blackColor
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
