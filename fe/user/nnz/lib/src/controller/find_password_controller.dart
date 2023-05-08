import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../services/user_provider.dart';

class FindPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final logger = Logger();
  late final phoneController;
  late final authNumberController;
  late final passwordController;
  late final passwordConfirmController;
  late Timer timer;
  RxBool numberChecked = false.obs;
  RxBool phoneChekced = false.obs;
  RxBool isAuthChecked = false.obs;
  RxBool requestSms = false.obs;
  RxBool pwdChecked = false.obs;
  RxBool pwdConfirmChecked = false.obs;
  RxBool findPwdChecked = false.obs;
  final RxInt totalCount = 120.obs;
  final RxString timeCount = "".obs;
  int seconds = 120;
  bool isTimerChecked = false;
  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    authNumberController = TextEditingController();
    passwordConfirmController = TextEditingController();
    passwordController = TextEditingController();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
  }

  @override
  void onClose() {
    super.onClose();
    if (timer.isActive) {
      timer.cancel();
    }
  }

  //sms 본인인증 요청
  Future<void> onSms() async {
    requestSms(true);

    startTimer();

    try {
      final response =
          await UserProvider().postReqVerify(phone: phoneController.text);
      //본인 핸드폰에 번호를 받았다는 이야기
      if (response.statusCode == 200) {
        //그럼 굳이 응답을 받아서 모델링을 할 필요가.....
        //인증번호가 들어갔다면 인증번호를 보냈다는 체크를 하고 유효시간 시작..

        startTimer();
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

  //비밀번호 유효성 검사
  bool onPasswordValidate({required String text}) {
    String pattern =
        r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(text)) {
      return false;
    }
    return true;
  }

  //인증번호 검사
  Future<void> onCheckAuthNumber() async {
    // isAuthChecked(true);
    // if (timer.isActive) {
    //   timer.cancel();
    // }
    try {
      final response = await UserProvider().postResVerify(
          phone: phoneController.text, verifyNum: authNumberController.text);
      if (response.statusCode == 200) {
        isAuthChecked(true);
        if (timer.isActive) {
          timer.cancel();
        }
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

  void startTimer() {
    if (timer.isActive) {
      timer.cancel();
      seconds = 120;
      totalCount(seconds);
      onTimer();
    } else {
      onTimer();
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return '$duration'.substring(2, 7);
  }

  void onPwdCheck() {
    logger.i("들어왔냠? ${pwdChecked.value}");
    logger.i("들어왔냠 확인? ${pwdConfirmChecked.value}");
    findPwdChecked.value =
        pwdChecked.value && pwdConfirmChecked.value ? true : false;
    logger.i("너 뭔데 ${findPwdChecked.value}");
  }

  void onTimer() {
    isTimerChecked = false;
    if (authNumberController.text.length >= 6) {
      isAuthChecked(true);
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        timeCount(format(seconds));
        if (seconds < 110) {
          phoneChekced.value = true;
        }
      } else {
        seconds = 120;
        isTimerChecked = true;
        isAuthChecked(false);
        timer.cancel();
      }
    });
  }

  Future<void> onFindPassword() async {
    logger.i("비밀번호 상태 ${pwdChecked.value}");
    logger.i("비밀번호확인 상태 ${pwdConfirmChecked.value}");
    logger.i("되냐? 상태 ${findPwdChecked.value}");
    try {
      final response = await UserProvider().patchPwd(
          phone: phoneController.text,
          pwd: passwordController.text,
          confirmPwd: passwordConfirmController.text);
      logger.i(response.statusCode);
      if (response.statusCode == 204) {
        showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text("비밀번호 변경되었습니다."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.offNamed("/login");

                      FocusScope.of(context).unfocus();
                    },
                    child: const Text("확인"),
                  ),
                ],
              );
            });
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
