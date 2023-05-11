import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/sharing_detail/perform_detail.dart';
import 'package:nnz/src/components/sharing_detail/test_infinite.dart';
import 'package:nnz/src/controller/list_scroll_controller.dart';

import 'package:nnz/src/components/sharing_detail/sharing_tag.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/perform_controller.dart';

class SharePerfomDetail extends StatelessWidget {
  SharePerfomDetail({super.key});

  final scrollControlloer = Get.put(InfiniteScrollController());
  final PerformController performController = Get.put(PerformController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: const Icon(Icons.account_circle),
        actions: const [Icon(Icons.notifications)],
      ),
      body: Obx(
        () => Column(children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(color: Color(0xFFE7E6E6)),
                width: double.infinity,
                height: 175,
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${performController.performData.value['title']}",
                      style: TextStyle(fontSize: 24, color: Config.blackColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/images/sharing_sample/peakfestival.gif",
                          height: 150,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: SizedBox(
                            width: 190,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                PerformDetail(
                                    performTitle:
                                        "${performController.performData.value['location']}",
                                    iconName: Icons.room,
                                    textSize: 16),
                                PerformDetail(
                                    performTitle:
                                        "${performController.performData.value['startDate']}",
                                    iconName: Icons.calendar_month,
                                    textSize: 16),
                                PerformDetail(
                                    performTitle:
                                        "${performController.performData.value['ageLimit']}",
                                    iconName: Icons.person,
                                    textSize: 16),
                                Container(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text("공연 예매하러 가기"),
                                    Container(
                                      width: 10,
                                    ),
                                    const Icon(Icons.arrow_forward)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: HashTagBadge(
              tags: {
                '#Peak': Color(0xFFF3C906),
                '#페스티벌': Color(0xFFF3C906),
                '#2023': Color(0xFFF3C906),
                '#전정국': Color(0xFFF3C906),
                '#BTS': Color(0xFFF3C906),
                '#포카나눔': Color(0xFFF3C906),
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 300,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TestInfinite(),
            ),
          ),
        ]),
      ),
    );
  }
}
