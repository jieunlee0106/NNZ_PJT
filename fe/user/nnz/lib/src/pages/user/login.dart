import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/icon_data.dart';

import '../../config/config.dart';
import '../../controller/login_controller.dart';

class Login extends StatelessWidget {
  final controller = Get.put(LoginController());
  final logger = Logger();
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Form(
          key: controller.loginKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Obx(
                      () => Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          iconData(
                            icon: ImagePath.logo,
                            size: 880,
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              controller.onChangeTextField(
                                  controller: controller.emailController,
                                  text: value);
                              controller.isChecked.value =
                                  controller.emailController.text.isNotEmpty &&
                                          controller.passwordController.text
                                              .isNotEmpty
                                      ? true
                                      : false;
                            },
                            decoration: const InputDecoration(
                              hintText: "이메일 입력",
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: controller.passwordController,
                            keyboardType: TextInputType.name,
                            obscureText: controller.visiblePassword.value,
                            onChanged: (value) {
                              controller.onChangeTextField(
                                  controller: controller.passwordController,
                                  text: value);
                              controller.isChecked.value =
                                  controller.emailController.text.isNotEmpty &&
                                          controller.passwordController.text
                                              .isNotEmpty
                                      ? true
                                      : false;
                            },
                            decoration: InputDecoration(
                              hintText: "비밀번호 입력",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.onVisible();
                                },
                                child: Icon(
                                  controller.visiblePassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/findPassword");
                            },
                            child: const Text(
                              "비밀번호를\t잊어버리셨나요?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: Get.width * 0.15,
                          // ),
                          GestureDetector(
                            onTap: () {
                              if (controller.isChecked.value) {
                                logger.i("로그인해줘");
                                controller.onLogin();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 32,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: controller.isChecked.value
                                      ? Config.yellowColor
                                      : Config.greyColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "로그인",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: controller.isChecked.value
                                          ? Config.blackColor
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
