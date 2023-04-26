import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  RxBool visiblePassword = true.obs;
  RxBool isChecked = false.obs;
  final logger = Logger();
  var loginKey = GlobalKey<FormState>();
  late final emailController;
  late final passwordController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  //각 TextEditingController에서의 text를 바꾸기 위한 메서드
  void onChangeTextField(
      {required TextEditingController controller, required String text}) {
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: text.length,
      ),
    );
    logger.i(text);
  }

  void onLogin() {
    bool checkEmail = isEmailValid(emailController.text);
    if (!checkEmail) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text("알림"),
            content: const Text("올바른 이메일 형식으로 입력해주세요"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    } else {
      logger.i("로그인진행하겠습니다.");
    }
  }

  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final emailRegExp = RegExp(pattern);
    return emailRegExp.hasMatch(email);
  }

  void onVisible() {
    visiblePassword(!visiblePassword.value);
  }
}
