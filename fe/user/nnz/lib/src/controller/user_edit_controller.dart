import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/register_form/share_popup.dart';
import 'package:nnz/src/services/user_provider.dart';

import 'my_page_controller.dart';

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

  bool test({required String value}) {
    return newPwdConfirmController.text == value ? true : false;
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
        nickChecked(available);
        if (nickChecked.value == false) {
          showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return const sharePopup(popupMessage: "중복된 닉네임입니다.");
              });
        } else {
          showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return const sharePopup(popupMessage: "사용가능한 닉네임입니다.");
              });
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
      if (response.statusCode == 204) {
        Get.find<MyPageController>().getMyInfo();
        await showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text("계정 수정 완료하였습니다."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("확인"),
                  ),
                ],
              );
            });

        Get.offNamed("/app");
      } else {
        await showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(response.body["message"]),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("확인"),
                  ),
                ],
              );
            });
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
