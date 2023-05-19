import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/user_edit_controller.dart';

class CurPwd extends StatefulWidget {
  const CurPwd({super.key});

  @override
  State<CurPwd> createState() => _CurPwdState();
}

class _CurPwdState extends State<CurPwd> {
  final controller = Get.put(UserEditController());

  final logger = Logger();
  bool curPwdObserser = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '현재 비밀번호',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Config.blackColor,
                  ),
                ),
              ),
              TextField(
                obscureText: curPwdObserser ? true : false,
                controller: controller.curPwdController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        curPwdObserser = !curPwdObserser;
                      });
                    },
                    child: Icon(
                      curPwdObserser
                          ? Icons.visibility
                          : Icons.visibility_off_rounded,
                    ),
                  ),
                  hintText: "현재 비밀번호를 입력해주세요",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
