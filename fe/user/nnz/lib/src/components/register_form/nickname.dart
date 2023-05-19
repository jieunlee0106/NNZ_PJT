import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../config/config.dart';
import '../../controller/register_controller.dart';

class Nickname extends GetView<RegisterController> {
  Nickname({super.key});
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            "닉네임",
            style: TextStyle(
              fontSize: 12,
              color: Config.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          child: Obx(
            () => Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.nicknameController,
                    onChanged: (value) {
                      controller.onChangeFiled(
                          controller: controller.nicknameController,
                          text: value);
                      controller.nicknameChecked.value =
                          controller.nicknameController.text.length >= 2
                              ? true
                              : false;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14.0),
                      hintText: "닉네임 입력(2자 이상)",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Config.hintTextColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.nicknameChecked.value) {
                      controller.onNicknameValidate(
                          nickname: controller.nicknameController.text);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: controller.nicknameChecked.value
                          ? Config.yellowColor
                          : Config.greyColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "중복 확인",
                      style: TextStyle(
                        fontSize: 14,
                        color: controller.nicknameChecked.value
                            ? Config.blackColor
                            : Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
