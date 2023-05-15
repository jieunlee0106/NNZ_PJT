import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../components/icon_data.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed("/app");
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: iconData(
                    icon: ImagePath.logo,
                    size: 880,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/registerForm");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13.0,
                            vertical: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              iconData(
                                icon: ImagePath.id,
                                size: 80,
                              ),
                              const Text(
                                "이메일 회원가입",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Container(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("이미 가입하셨나요?"),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/login");
                              },
                              child: const Text(
                                "로그인",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
