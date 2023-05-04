import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';

class OtherSharingDetail extends StatelessWidget {
  const OtherSharingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "나눔 내역",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Config.blackColor,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffFFFAEA),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "전체",
                          style: TextStyle(
                            fontSize: 14,
                            color: Config.blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "4",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFF6666),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "나눔 한",
                          style: TextStyle(
                            fontSize: 14,
                            color: Config.blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "2",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff848484),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "나눔 받은",
                          style: TextStyle(
                            fontSize: 14,
                            color: Config.blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "4",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff848484),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconData(
                  icon: ImagePath.declare,
                  size: 80,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Text("현재 경고가 2회 누적된 사용자입니다."),
              ],
            )
          ],
        ),
      ),
    );
  }
}
