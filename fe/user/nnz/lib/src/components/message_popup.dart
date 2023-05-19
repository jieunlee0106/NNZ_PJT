import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';

class MessagePopup extends StatelessWidget {
  final String title;
  final String message;
  final Function() okCallBack;
  final Function() cancelCallback;
  const MessagePopup({
    super.key,
    required this.title,
    required this.message,
    required this.okCallBack,
    required this.cancelCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Container(
              width: Get.width * 0.7,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Config.titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: Config.contentSize,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: okCallBack,
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(
                              "확인",
                              style: TextStyle(
                                fontSize: Config.contentSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: cancelCallback,
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(
                              "취소",
                              style: TextStyle(
                                fontSize: Config.contentSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
