import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/controller/find_password_controller.dart';

import '../../config/config.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final controller = Get.put(FindPasswordController());
  bool isPassword = false;
  bool isPasswordConfirm = false;
  bool passwordObserver = false;
  bool passwordConfirmObserver = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 4,
          ),
          child: Text("비밀번호"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            controller: controller.passwordController,
            onChanged: (value) {
              final isValidPassword =
                  controller.onPasswordValidate(text: value);
              print("도대체 왜 $isValidPassword");
              controller.pwdChecked.value = isValidPassword;

              controller.pwdConfirmChecked.value =
                  controller.passwordController.text ==
                          controller.passwordConfirmController.text
                      ? true
                      : false;
              controller.onPwdCheck();
            },
            validator: (value) {
              isPassword = controller.onPasswordValidate(text: value!);
              controller.pwdChecked.value = isPassword == true ? true : false;

              return isPassword ? null : "숫자, 문자, 특수문자 포함 8자 이상 입력해주세요";
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.name,
            obscureText: passwordObserver ? false : true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14.0),
              hintText: "새로운 비밀번호를 입력해주세요",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Config.hintTextColor,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  passwordObserver = !passwordObserver;
                  setState(() {});
                },
                child: Icon(passwordObserver
                    ? Icons.visibility_off_rounded
                    : Icons.visibility),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            "비밀번호 확인",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller.passwordConfirmController,
            onChanged: (value) {
              final isValidPwdConfirm = controller.passwordController.text ==
                  controller.passwordConfirmController.text;
              controller.pwdConfirmChecked.value = isValidPwdConfirm;
              controller.onPwdCheck();
            },
            validator: (text) {
              Logger().i(controller.passwordController.text ==
                  controller.passwordConfirmController.text);
              isPasswordConfirm = controller.passwordController.text ==
                      controller.passwordConfirmController.text
                  ? true
                  : false;
              controller.pwdConfirmChecked.value =
                  isPasswordConfirm ? true : false;

              return isPasswordConfirm ? null : "비밀번호가 일치하지 않습니다.";
            },
            keyboardType: TextInputType.name,
            obscureText: passwordConfirmObserver ? false : true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14.0),
              hintText: "비밀번호를 다시 한 번 입력해주세요",
              suffixIcon: GestureDetector(
                  onTap: () {
                    passwordConfirmObserver = !passwordConfirmObserver;
                    setState(() {});
                  },
                  child: Icon(
                    passwordConfirmObserver
                        ? Icons.visibility_off_rounded
                        : Icons.visibility,
                  )),
              hintStyle: TextStyle(
                fontSize: 14,
                color: Config.hintTextColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
