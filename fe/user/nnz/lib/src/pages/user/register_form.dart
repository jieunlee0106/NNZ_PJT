import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/register_form/agree.dart';
import '../../components/register_form/auth_btn.dart';
import '../../components/register_form/email.dart';
import '../../components/register_form/nickname.dart';
import '../../components/register_form/password.dart';
import '../../components/register_form/password_confirm.dart';
import '../../components/register_form/sms.dart';
import '../../controller/register_controller.dart';

class RegisterForm extends StatelessWidget {
  final controller = Get.put(RegisterController());
  RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "회원가입",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        const Email(),
                        const Password(),
                        const PasswordConfirm(),
                        Nickname(),
                        Sms(),
                        const Agree(),
                        const AuthBtn(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
