import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/find_password_controller.dart';

import '../../components/find_password_form/auth_number.dart';
import '../../components/find_password_form/find_password_btn.dart';
import '../../components/find_password_form/new_password.dart';
import '../../components/find_password_form/phone_number.dart';

class FindPassword extends StatelessWidget {
  FindPassword({super.key});
  final controller = Get.put(FindPasswordController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: controller.formKey,
                child: Container(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 4,
                          ),
                          child: Text("나너주 가입 시 사용한 휴대폰 번호를 입력해주세요"),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        PhoneNumber(),
                        const SizedBox(
                          height: 12,
                        ),
                        controller.isAuthChecked.value
                            ? const NewPassword()
                            : controller.requestSms.value
                                ? AuthNumber()
                                : Container(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FindPasswordBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
