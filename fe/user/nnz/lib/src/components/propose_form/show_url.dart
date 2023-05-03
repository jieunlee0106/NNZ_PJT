import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/propose_controller.dart';

import '../../config/config.dart';
import '../icon_data.dart';

class ShowUrl extends StatelessWidget {
  ShowUrl({super.key});
  final controller = Get.put(ProposeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 28,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              iconData(
                icon: ImagePath.detailInfo,
                size: 80,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "관련 URL",
                style: TextStyle(
                  fontSize: 18,
                  color: Config.blackColor,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: controller.showUrlController,
            decoration: const InputDecoration(
              hintText: "URL 입력해주세요",
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
