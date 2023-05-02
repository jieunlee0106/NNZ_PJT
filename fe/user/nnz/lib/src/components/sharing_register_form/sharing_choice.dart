import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/sharing_register_form/share_alert.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

import '../../config/config.dart';
import '../icon_data.dart';

class SharingChoice extends StatefulWidget {
  const SharingChoice({super.key});

  @override
  State<SharingChoice> createState() => _SharingChoiceState();
}

class _SharingChoiceState extends State<SharingChoice> {
  final logger = Logger();

  final controller = Get.put(SharingRegisterController());
  final List<String> _items = ['콘서트', '뮤지컬', '연극', '영화', '스포츠'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconData(
                icon: ImagePath.choice,
                size: 80,
              ),
              const SizedBox(
                width: 8,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  "공연 선택",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * 0.7,
                  child: TextField(
                    enableInteractiveSelection: false,
                    readOnly: true,
                    controller: controller.sharingController,
                    decoration: const InputDecoration(
                        hintText: '조회 버튼을 눌러 공연을 선택해주세요',
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    logger.i("공연 선택을 해주세요");
                    logger.i(_items);

                    showDialog(
                      context: context,
                      barrierDismissible: true, // 다이얼로그 바깥을 탭하면 닫히도록 설정
                      builder: (BuildContext context) {
                        return const ShareAlert();
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Config.yellowColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Text(
                        "조회",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
