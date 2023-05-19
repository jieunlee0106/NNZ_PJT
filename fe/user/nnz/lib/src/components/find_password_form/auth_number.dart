import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/find_password_controller.dart';

class AuthNumber extends StatelessWidget {
  AuthNumber({super.key});
  final controller = Get.put(FindPasswordController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              width: Get.width * 0.6,
              child: TextField(
                controller: controller.authNumberController,
                onChanged: (text) {
                  controller.numberChecked.value =
                      controller.authNumberController.text.length >= 6
                          ? true
                          : false;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "인증번호 6자리 입력해주세요",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Config.hintTextColor,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        controller.timeCount.value,
                        style: const TextStyle(
                          color: Color(0xffE02727),
                        ),
                      ),
                    )),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              if (controller.numberChecked.value) {
                controller.onCheckAuthNumber();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: controller.numberChecked.value
                    ? Config.yellowColor
                    : Config.greyColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "확인",
                style: TextStyle(
                  fontSize: 14,
                  color: controller.numberChecked.value
                      ? Config.blackColor
                      : Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
