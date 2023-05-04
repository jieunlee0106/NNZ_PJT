import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/services/user_provider.dart';

class RegisterController extends GetxController {
  late final GlobalKey formKey;
  final logger = Logger();
  RxString timeCount = "".obs;
  int count = 10;
  final RxInt totalCount = 120.obs;
  late Timer timer;
  RxBool nicknameChecked = false.obs;
  RxBool phoneChecked = false.obs;
  RxBool requestSms = false.obs;
  RxBool requestAgainSms = false.obs;
  RxBool isAuthChecked = false.obs;

  bool isTimerChecked = false;

  //회원 유효성 검사 완료 후 회원가입 버튼은 활성화 하기 위해
  RxBool emailChecked = false.obs;
  RxBool emailValidateCheck = false.obs;
  RxBool pwdChecked = false.obs;
  RxBool pwdConfirmChecked = false.obs;
  RxBool nickChecked = false.obs;
  RxBool nickValidateCheck = false.obs;
  RxBool smsChecked = false.obs;
  RxBool isAgree = false.obs;
  RxBool registerChecked = false.obs;

  RxString test = "".obs;
  int seconds = 120; // seconds 변수 추가

  late final emailController;
  late final passwordController;
  late final passwordConfirmController;
  late final nicknameController;
  late final smsController;
  late final authNumberController;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    nicknameController = TextEditingController();
    smsController = TextEditingController();
    authNumberController = TextEditingController();
    totalCount(count);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
  }

  @override
  void onClose() {
    super.onClose();
    if (timer.isActive) {
      timer.cancel();
    }
  }

  bool changeAgree(bool value) {
    print(value);
    return false;
  }

  void onChangeFiled(
      {required TextEditingController controller, required String text}) {
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: text.length,
      ),
    );
    if (controller == passwordConfirmController) {
      logger.i("자 확인들어갑니다. $pwdConfirmChecked");
      onRegisterCheck();
    }
  }

  void onRegisterCheck() {
    logger.i("비밀번호 체크 ${pwdChecked.value}");
    registerChecked.value = emailChecked.value &&
            pwdChecked.value &&
            pwdConfirmChecked.value &&
            nickChecked.value &&
            smsChecked.value &&
            isAgree.value
        ? true
        : false;
  }

  //이메일형식 확인뒤 중복체크
  void emailValidate({required String type, required String text}) {
    logger.i("$type , $text");
    UserProvider().testApi(type: type, text: text);

    //이메일 유효성 검사 통과시
    emailChecked(true);
    logger.i("이메일 통과됐나요? ${emailChecked.value}");
    // UserProvider().getValidateEmail(email: emailController.text);
  }

  void onSms() {
    requestSms(true);
    phoneChecked(false);
    requestAgainSms(false);
    logger.i(phoneChecked.value);
    startTimer();
  }

  bool onEmailValidate({required String text}) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(text)) {
      return false;
    }
    return true;
  }

  bool onPasswordValidate({required String text}) {
    String pattern =
        r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(text)) {
      return false;
    }
    return true;
  }

  void onNicknameValidate(
      {String type = "nickname", required String nickname}) {
    // logger.i(nickname);
    nickChecked(true);
    onRegisterCheck();
    UserProvider().testApi(type: type, text: nickname);
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return '$duration'.substring(2, 7);
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

  void onTest() {
    smsChecked(true);
    onRegisterCheck();
    if (timer.isActive) {
      timer.cancel();
    }
  }

  void onTimer() {
    isTimerChecked = false;
    if (authNumberController.text.length >= 6) {
      isAuthChecked(true);
    }
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          seconds--;
          timeCount(
            format(seconds),
          );
          if (seconds < 110) {
            phoneChecked.value = true;
          }
        } else {
          seconds = 120;
          print("멈춰");
          isTimerChecked = true;
          isAuthChecked(false);
          timer.cancel();
        }
      },
    );
  }

  void onRegister() {
    logger.i(emailChecked.value);
    logger.i(pwdChecked.value);
    logger.i(pwdConfirmChecked.value);
    logger.i(nickChecked.value);
    logger.i(smsChecked.value);
    logger.i(isAgree.value);

    //회원가입 api 수행
  }
}
