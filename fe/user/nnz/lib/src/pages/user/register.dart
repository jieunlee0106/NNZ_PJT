import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/controller/twitter_controller.dart';

import '../../components/icon_data.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final logger = Logger();
  final controller = Get.put(TwitterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            TextButton(
              onPressed: () {
                Get.offNamed("/app");
              },
              child: const Text("닫기"),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: iconData(
                  icon: ImagePath.logo,
                  size: 880,
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: controller.twitter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff2c96d4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconData(
                            icon: ImagePath.twitter,
                            size: 80,
                          ),
                          const Text(
                            "트위터로 시작하기",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                            "아이디로 시작하기",
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
            ],
          ),
        ));
  }
}
