import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controller/register_controller.dart';

class Agree extends GetView<RegisterController> {
  const Agree({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                activeColor: Config.blackColor,
                value: controller.isAgree.value,
                onChanged: (value) {
                  controller.isAgree(value);
                  controller.onRegisterCheck();
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Text(
                  "(필수) 개인정보 수집 / 이용 동의",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed("/termsOfUse");
            },
            child: const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
