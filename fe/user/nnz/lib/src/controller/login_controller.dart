import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';

import '../services/user_provider.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  final storage = const FlutterSecureStorage();
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

  Future<void> onLogin() async {
    bool checkEmail = isEmailValid(emailController.text);
    if (!checkEmail) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
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
      logger.i("로그인진행하겠습니다. ${Get.find<BottomNavController>().curIndex.value}");
      // final response = UserProvider().postLogin(
      //     email: emailController.text, password: passwordController.text);
      // logger.i(response);

      try {
        final response = await UserProvider().postLogin(
            email: emailController.text, password: passwordController.text);
        logger.i(response.statusCode);
        if (response.statusCode == 200) {
          logger.i(response.body);

          final accessToken = response.body["accessToken"];
          final userId = response.body["userId"];
          // final userId = response.body["userId"];
          Get.find<BottomNavController>().setToken(accessToken: accessToken);
          Get.find<BottomNavController>().setUserId(userId: userId);
          final token = Get.find<BottomNavController>().getToken();
          Get.offNamed("/app");
          Get.find<BottomNavController>()
              .changeBottomNav(Get.find<BottomNavController>().curIndex.value);
        } else {
          final errorMessage = "(${response.statusCode}): ${response.body}";
          logger.e(errorMessage);
          throw Exception(errorMessage);
        }
      } catch (e) {
        final errorMessage = "$e";
        logger.e(errorMessage);
        throw Exception(errorMessage);
      }
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
