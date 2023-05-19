import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../controller/register_controller.dart';

class AuthBtn extends StatefulWidget {
  const AuthBtn({super.key});

  @override
  State<AuthBtn> createState() => _AuthBtnState();
}

class _AuthBtnState extends State<AuthBtn> {
  final controller = Get.put(RegisterController());
  @override
  void initState() {
    super.initState();
    controller.onRegisterCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            controller.onRegister();
            print(controller.registerChecked.value);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: controller.registerChecked.value
                    ? Config.yellowColor
                    : Config.greyColor,
              ),
              child: Center(
                child: Text(
                  "회원가입",
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.registerChecked.value
                        ? Config.blackColor
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
