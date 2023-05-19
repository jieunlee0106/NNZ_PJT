import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sharing_register_controller.dart';
import '../icon_data.dart';

class SharingTitle extends StatelessWidget {
  SharingTitle({Key? key}) : super(key: key);
  final controller = Get.put(SharingRegisterController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconData(
                icon: ImagePath.title,
                size: 80,
              ),
              const SizedBox(
                width: 12,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 4,
                ),
                child: Text(
                  "제목",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
            child: TextField(
              controller: controller.titleController,
              keyboardType: TextInputType.name,
              maxLines: null,
              // textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "제목을 입력해주세요",
                enabledBorder: InputBorder.none,
                alignLabelWithHint: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
