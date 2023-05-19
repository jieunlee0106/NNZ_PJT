import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/register_form/register_field.dart';

import '../../config/config.dart';
import '../../controller/register_controller.dart';

class Password extends GetView<RegisterController> {
  const Password({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text("비밀번호",
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
            controller: controller.passwordController,
            type: TextInputType.visiblePassword,
            formType: 'password',
            hintText: "숫자, 영문, 특수문자 8자 이상 입력",
            suf: Icons.visibility,
            observer: true,
          ),
        )
      ],
    );
  }
}
