import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/user_edit_controller.dart';

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
              controller.onUpdateUser();
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
          Container(
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
        ],
      ),
    );
  }
}
