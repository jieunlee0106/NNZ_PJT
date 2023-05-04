import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';

class NoResultSearch extends StatelessWidget {
  NoResultSearch({super.key});
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              iconData(
                icon: ImagePath.sad,
                size: 240,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "검색 결과가 없습니다.",
                style: TextStyle(
                  fontSize: 16,
                  color: Config.blackColor,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "원하는 공연이 없다면 나너주에게 알려주세요",
                style: TextStyle(
                  fontSize: 16,
                  color: Config.blackColor,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/proposeShow");
                },
                child: Text(
                  "+ 공연제안하기",
                  style: TextStyle(
                    fontSize: 20,
                    color: Config.deepYellowColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
