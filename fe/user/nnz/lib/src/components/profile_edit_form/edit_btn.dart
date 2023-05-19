import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';

import '../../controller/user_edit_controller.dart';

class EditBtn extends StatelessWidget {
  EditBtn({super.key});
  final controller = Get.put(UserEditController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.find<UserEditController>().onUpdateUser();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Config.yellowColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Text(
                '회원 수정',
                style: TextStyle(
                    color: Config.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('알림'),
                      content: const Text('정말로 삭제하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.find<UserEditController>().deleteUser();
                          },
                          child: const Text('예'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('아니오'),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Config.yellowColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Text(
                '회원 탈퇴',
                style: TextStyle(
                    color: Config.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
