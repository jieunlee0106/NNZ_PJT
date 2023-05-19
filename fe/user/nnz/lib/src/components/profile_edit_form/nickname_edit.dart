import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/controller/user_edit_controller.dart';

import '../../config/config.dart';
import '../register_form/share_popup.dart';

class NicknameEdit extends StatelessWidget {
  NicknameEdit({super.key});
  final controller = Get.put(UserEditController());

  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '닉네임',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Config.blackColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.nickController,
                      decoration: InputDecoration(
                        hintText: "변경하실 닉네임을 입력해주세요",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.nickController.text == '') {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const sharePopup(
                                  popupMessage: "닉네임을 입력해주세요");
                            });
                      } else {
                        controller.nickValidate(
                          type: "nickname",
                          text: controller.nickController.text,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: Config.yellowColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '중복 확인',
                        style: TextStyle(
                            color: Config.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
