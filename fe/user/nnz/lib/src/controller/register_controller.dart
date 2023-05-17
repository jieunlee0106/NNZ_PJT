import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/services/user_provider.dart';

import '../components/register_form/share_popup.dart';
import '../model/register_model.dart';

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
  String? textError;
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
    registerChecked.value = emailChecked.value &&
            pwdChecked.value &&
            pwdConfirmChecked.value &&
            nickChecked.value &&
            smsChecked.value &&
            isAgree.value
        ? true
        : false;
  }

  //sms 인증 요청
  void onSms() async {
    // phoneChecked(false);

    logger.i(phoneChecked.value);
    // startTimer003892();
    //sms 인증번호 요청 서버 api 통신가능하면 주석 풀것
    try {
      final response =
          await UserProvider().postReqVerify(phone: smsController.text);
      if (response.statusCode == 200) {
        requestSms(true);
        phoneChecked(false);
        startTimer();
        logger.i("본인요청 api ${response.body}");
      } else {
        showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return sharePopup(popupMessage: "${response.body["message"]}");
            });
      }
      final errorMessage = "(${response.statusCode}): ${response.body}";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
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

  String? onEmailCheck() {
    if (emailChecked.value == false) {
      return "중복된이메일입니다.";
    } else {
      return null;
    }
  }

  //이메일형식 확인뒤 중복체크
  Future<void> emailValidate(
      {required String type, required String text}) async {
    logger.i("$type , $text");

    //이메일 유효성 검사 통과시 서버에서 api 통신 가능하면 주석 풀것

    // logger.i("이메일 통과됐나요? ${emailChecked.value}");

    try {
      final response =
          await UserProvider().getValidate(type: type, value: text);
      if (response.statusCode == 200) {
        logger.i(response.body);
        final available = response.body["available"];
        emailChecked.value = response.body["available"];
        if (!available) {
          onRegisterCheck();
        } else {
          emailChecked.value = true;
          onRegisterCheck();
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

  bool testResult() {
    return emailChecked.value == true ? true : false;
  }

  Future<void> onNicknameValidate(
      {String type = "nickname", required String nickname}) async {
    // logger.i(nickname);

    // nickChecked(true);
    // onRegisterCheck();

    //서버에서 api 가능 하면 주석 풀것
    try {
      final response =
          await UserProvider().getValidate(type: type, value: nickname);
      if (response.statusCode == 200) {
        logger.i(response.body);
        final available = response.body["available"];
        if (!available) {
          nickChecked(available);
          showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return const sharePopup(popupMessage: "중복된 닉네임입니다.");
              });
        } else {
          nickChecked(available);
          showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return const sharePopup(popupMessage: "사용가능한 닉네임입니다.");
              });
        }
        onRegisterCheck();
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

  //인증번호 통과 유무.....

  Future<void> onPhoneAuthNumberVerity() async {
    logger.i(authNumberController.text);

    // 서버에서 api 통신이 가능하면 주석 풀 것
    try {
      final response = await UserProvider().postResVerify(
          phone: smsController.text, verifyNum: authNumberController.text);
      logger.i("인증번호 : ${authNumberController.text}");
      if (response.statusCode == 200) {
        final verify = response.body["verify"];
        logger.i(response.body);
        if (verify == false) {
          smsChecked(verify);
          showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return const sharePopup(popupMessage: "유효하지않는 인증번호입니다.");
              });
          onRegisterCheck();
        } else {
          smsChecked(verify);
          onRegisterCheck();
          if (timer.isActive) {
            timer.cancel();
          }
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

  void onTimer() {
    isTimerChecked = false;
    //인증번호가 6자리면 통과
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

  Future<void> onRegister() async {
    logger.i(emailChecked.value);
    logger.i(pwdChecked.value);
    logger.i(pwdConfirmChecked.value);
    logger.i(nickChecked.value);
    logger.i(smsChecked.value);
    logger.i(isAgree.value);

    //회원가입 api 수행
    final user = RegisterModel(
      email: emailController.text,
      pwd: passwordController.text,
      confirmPwd: passwordConfirmController.text,
      nickname: nicknameController.text,
      phone: smsController.text,
    );
    // logger.i(user);

    try {
      final response = await UserProvider().postRegister(user: user);
      logger.i(response.statusCode);
      if (response.statusCode == 204) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('회원가입 되었습니다.'),
          ),
        );
        Get.offAllNamed("/register");
        // showDialog(
        //     context: Get.context!,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         content: const Text("회원가입되었습니다."),
        //         actions: [
        //           TextButton(
        //             onPressed: () {
        //               FocusScope.of(context).unfocus();
        //             },
        //             child: const Text("확인"),
        //           ),
        //         ],
        //       );
        //     });
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
