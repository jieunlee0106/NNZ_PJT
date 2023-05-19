import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/register_form/register_field.dart';

import '../../config/config.dart';
import '../../controller/register_controller.dart';

class PasswordConfirm extends GetView<RegisterController> {
  const PasswordConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text("비밀번호 확인",
              style: TextStyle(
                fontSize: 12,
                color: Config.blackColor,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          child: RegisterField(
            controller: controller.passwordConfirmController,
            type: TextInputType.name,
            formType: 'passwordConfirm',
            hintText: "비밀번호 확인",
            suf: Icons.visibility,
            observer: true,
          ),
        )
      ],
    );
  }
}
