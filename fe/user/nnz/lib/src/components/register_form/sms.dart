import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../config/config.dart';
import '../../controller/register_controller.dart';

class Sms extends StatelessWidget {
  Sms({super.key});
  final logger = Logger();
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text("sms 본인인증",
                style: TextStyle(
                  fontSize: 12,
                  color: Config.blackColor,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: controller.smsChecked.value ? true : false,
                    controller: controller.smsController,
                    onChanged: (value) {
                      controller.onChangeFiled(
                          controller: controller.smsController, text: value);
                      controller.phoneChecked.value =
                          controller.smsController.text.length == 11
                              ? true
                              : false;
                      logger.i(controller.phoneChecked.value);
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14.0),
                      hintText: "휴대폰 번호를 입력해주세요",
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
                    if (controller.phoneChecked.value &&
                        controller.smsChecked.value == false) {
                      controller.onSms();
                    }
                  },
                  child: Container(
                    padding: controller.requestSms.value
                        ? const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 15,
                          )
                        : const EdgeInsets.all(
                            14,
                          ),
                    decoration: BoxDecoration(
                      color: controller.smsChecked.value == true
                          ? Config.greyColor
                          : controller.phoneChecked.value
                              ? Config.yellowColor
                              : Config.greyColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: controller.smsChecked.value
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
                              color: controller.phoneChecked.value
                                  ? Config.blackColor
                                  : Colors.white,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
          controller.smsChecked.value
              ? Container()
              : controller.requestSms.value
                  ? Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.authNumberController,
                              onChanged: (value) {
                                controller.onChangeFiled(
                                    controller: controller.authNumberController,
                                    text: value);
                                controller.isAuthChecked.value = controller
                                            .authNumberController.text.length >=
                                        6
                                    ? true
                                    : false;
                                controller.update();
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14.0),
                                hintText: "인증번호 6자리를 입력해주세요",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Config.hintTextColor,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    controller.timeCount.value,
                                    style: const TextStyle(
                                      color: Color(0xffE02727),
                                    ),
                                  ),
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
                              if (controller.isAuthChecked.value) {
                                controller.onPhoneAuthNumberVerity();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: controller.isAuthChecked.value
                                    ? Config.yellowColor
                                    : Config.greyColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "확인",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: controller.isAuthChecked.value
                                      ? Config.blackColor
                                      : Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container()
        ],
      ),
    );
  }
}
