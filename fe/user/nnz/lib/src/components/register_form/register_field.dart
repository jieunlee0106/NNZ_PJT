import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../config/config.dart';
import '../../controller/register_controller.dart';

class RegisterField extends StatefulWidget {
  RegisterField(
      {Key? key,
      required this.controller,
      required this.type,
      required this.hintText,
      required this.formType,
      this.suf,
      this.observer,
      this.validation})
      : super(key: key);

  final TextEditingController controller;
  final TextInputType type;
  final String hintText;
  final IconData? suf;
  final String Function(dynamic value)? validation;
  final String formType;
  bool? observer;

  @override
  State<RegisterField> createState() => _RegisterFieldState();
}

class _RegisterFieldState extends State<RegisterField> {
  final controller = Get.put(RegisterController());
  final logger = Logger();
  bool isEmail = false;
  bool isPassword = false;
  bool isPasswordConfirm = false;
  bool isTest = false;
  bool? emailCheck = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      keyboardType: widget.type,
      obscureText: widget.observer ?? false,
      onChanged: (value) async {
        final controller = Get.find<RegisterController>();
        controller.onChangeFiled(
          controller: widget.controller,
          text: value,
        );

        if (widget.formType == 'email') {
          final isValidEmail = controller.onEmailValidate(text: value);
          if (isValidEmail == true) {
            logger.i(emailCheck);
          }
        } else if (widget.formType == 'password') {
          final isValidPassword = controller.onPasswordValidate(text: value);
          controller.pwdChecked.value = isValidPassword;
          final isValidPasswordConfirm =
              controller.passwordController.text == widget.controller.text;
          controller.pwdConfirmChecked.value = isValidPasswordConfirm;
        } else if (widget.formType == 'passwordConfirm') {
          final isValidPasswordConfirm =
              controller.passwordController.text == widget.controller.text;
          controller.pwdConfirmChecked.value = isValidPasswordConfirm;
        }

        controller.onRegisterCheck();
      },
      validator: (value) {
        if (widget.formType == 'email') {
          isEmail = controller.onEmailValidate(text: value!);

          logger.i("여기서는 $emailCheck");
          if (!isEmail) {
            return '올바른 이메일 형식으로 입력해주세요';
          } else {
            controller.emailValidate(type: 'email', text: value).then((_) {
              if (controller.emailChecked.value == false) {
                isTest = controller.emailChecked.value;
                setState(() {});
              } else {
                isTest = controller.emailChecked.value;
                setState(() {});
              }
            });
            if (isTest == false) {
              return '중복된 이메일입니다.';
            } else {
              return null;
            }
          }
        } else if (widget.formType == 'password') {
          isPassword = controller.onPasswordValidate(text: value!);
          controller.pwdChecked.value = isPassword == true ? true : false;

          return isPassword ? null : "숫자, 문자, 특수문자 포함 8자 이상";
        } else if (widget.formType == 'passwordConfirm') {
          isPasswordConfirm =
              controller.passwordController.text == widget.controller.text
                  ? true
                  : false;
          controller.pwdConfirmChecked.value = isPasswordConfirm ? true : false;

          return isPasswordConfirm ? null : "비밀번호가 일치하지 않습니다.";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Config.hintTextColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: widget.observer != null
            ? GestureDetector(
                onTap: () {
                  widget.observer = !widget.observer!;
                  setState(() {});
                },
                child: Icon(
                  widget.observer! ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}
