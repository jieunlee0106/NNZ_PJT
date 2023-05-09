import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/services/user_provider.dart';

class UserEditController extends GetxController {
  late final curPwdController;
  late final newPwdController;
  late final newPwdConfirmController;
  late final nickController;
  File? imageFile;
  final logger = Logger();
  RxBool nickChecked = false.obs;
  RxBool pwdChecked = false.obs;
  RxBool pwdConfirmChekced = false.obs;
  @override
  void onInit() {
    super.onInit();
    curPwdController = TextEditingController();
    newPwdController = TextEditingController();
    newPwdConfirmController = TextEditingController();
    nickController = TextEditingController();
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

  //닉네임 중복확인
  Future<void> nickValidate(
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
        nickChecked.value = response.body["available"];
        if (!available) {
        } else {
          nickChecked.value = true;
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

  //유저 정보 수정
  Future<void> onUpdateUser() async {
    try {
      final response = await UserProvider().patchUser(
          image: imageFile!,
          oldPwd: curPwdController.text,
          newPwd: newPwdController.text,
          confirmNewPwd: newPwdConfirmController.text,
          nickname: nickController.text);
      logger.i(response.statusCode.runtimeType);
      if (response.statusCode == 204) {
        logger.i("이동합니다.");
        Get.back();
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
