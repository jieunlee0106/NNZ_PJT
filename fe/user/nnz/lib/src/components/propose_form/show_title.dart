import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/propose_controller.dart';

class ShowTitle extends StatelessWidget {
  ShowTitle({super.key});
  final controller = Get.put(ProposeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "공연 제안하기",
            //   style: TextStyle(
            //     fontSize: 20,
            //     color: Config.blackColor,
            //   ),
            // ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                iconData(
                  icon: ImagePath.title,
                  size: 80,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "공연명",
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
              controller: controller.showTitleController,
              decoration: const InputDecoration(
                hintText: "제목 입력해주세요",
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
