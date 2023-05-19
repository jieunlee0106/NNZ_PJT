import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/user_edit_controller.dart';

class NewPwd extends StatefulWidget {
  const NewPwd({super.key});

  @override
  State<NewPwd> createState() => _NewPwdState();
}

class _NewPwdState extends State<NewPwd> {
  final controller = Get.put(UserEditController());
  bool newPwdObserver = true;
  bool newPwdConfirmObserver = true;
  bool test = false;
  bool isPwd = false;

  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '새로운 비밀번호',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Config.blackColor,
            ),
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.newPwdController,
          obscureText: newPwdObserver ? true : false,
          onChanged: (value) {
            final isValidPassword = controller.onPasswordValidate(text: value);
            controller.pwdChecked.value = isValidPassword;

            controller.pwdConfirmChekced.value =
                controller.newPwdController.text ==
                        controller.newPwdConfirmController.text
                    ? true
                    : false;
            setState(() {
              test = controller.pwdConfirmChekced.value;
            });
            controller.update();
          },
          validator: (value) {
            isPwd = controller.onPasswordValidate(text: value!);
            controller.pwdChecked.value = isPwd ? true : false;
            logger.i(controller.pwdChecked.value);
            return isPwd ? null : "숫자, 문자, 특수문자 포함 8자 이상";
          },
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  newPwdObserver = !newPwdObserver;
                });
              },
              child: Icon(
                newPwdObserver
                    ? Icons.visibility
                    : Icons.visibility_off_rounded,
              ),
            ),
            hintText: "변경하실 비밀번호를 입력해주세요",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '새로운 비밀번호 확인',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Config.blackColor,
            ),
          ),
        ),
        TextFormField(
          obscureText: newPwdConfirmObserver ? true : false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            final isValidPwdConfirm = controller.newPwdController.text ==
                controller.newPwdConfirmController.text;
            controller.pwdConfirmChekced.value = isValidPwdConfirm;
          },
          validator: (value) {
            return controller.pwdConfirmChekced.value
                ? null
                : "비밀번호가 일치 하지 않습니다.";
          },
          controller: controller.newPwdConfirmController,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  newPwdConfirmObserver = !newPwdConfirmObserver;
                });
              },
              child: Icon(
                newPwdConfirmObserver
                    ? Icons.visibility
                    : Icons.visibility_off_rounded,
              ),
            ),
            hintText: "비밀번호를 다시 한 번 입력해주세요",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }
}
