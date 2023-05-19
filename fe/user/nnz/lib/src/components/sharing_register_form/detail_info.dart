import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sharing_register_controller.dart';
import '../icon_data.dart';

class DetailInfo extends StatelessWidget {
  DetailInfo({super.key});
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
                icon: ImagePath.detailInfo,
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
                  "상세정보",
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
              controller: controller.detailController,
              keyboardType: TextInputType.name,
              maxLines: null,
              // textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "내용을 입력해주세요",
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
