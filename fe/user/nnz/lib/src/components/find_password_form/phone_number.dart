import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/find_password_controller.dart';

class PhoneNumber extends StatelessWidget {
  PhoneNumber({super.key});
  final controller = Get.put(FindPasswordController());
  final logger = Logger();
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
                onChanged: (text) {
                  logger.i(controller.phoneController.text);
                  controller.phoneChekced.value =
                      controller.phoneController.text.length >= 11
                          ? true
                          : false;
                },
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "숫자만 입력해주세요",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Config.hintTextColor,
                    )),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              if (controller.phoneChekced.value &&
                  controller.isAuthChecked.value == false) {
                controller.onSms();
              }
            },
            child: Container(
              padding: controller.requestSms.value
                  ? const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 16,
                    )
                  : const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: controller.isAuthChecked.value
                    ? Config.greyColor
                    : controller.phoneChekced.value
                        ? Config.yellowColor
                        : Config.greyColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: controller.isAuthChecked.value
                  ? const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Text(
                        "인증 완료",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      controller.requestSms.value ? "인증 재요청" : "인증 요청",
                      style: TextStyle(
                        fontSize: 14,
                        color: controller.phoneChekced.value
                            ? Config.blackColor
                            : Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
