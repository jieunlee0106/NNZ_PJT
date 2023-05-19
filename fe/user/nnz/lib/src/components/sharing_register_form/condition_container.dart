import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

import '../../config/config.dart';
import '../icon_data.dart';

class ConditionContainer extends StatelessWidget {
  ConditionContainer({super.key});
  final controller = Get.put(SharingRegisterController());
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconData(
                  icon: ImagePath.condition,
                  size: 80,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "조건",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Get.width * 0.7,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: controller.conditionController,
                          decoration: const InputDecoration(
                            hintText: "조건을 입력해주세요",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addCondition(
                              controller.conditionController.text);
                          controller.conditionController.text = "";
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Config.yellowColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Text(
                              "추가하기",
                              style: TextStyle(color: Config.blackColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                controller.conList.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Column(
                          children: [
                            for (var condition in controller.conList) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(condition),
                                    GestureDetector(
                                        onTap: () {
                                          controller.removeCondition(condition);
                                        },
                                        child: const Icon(
                                            Icons.remove_circle_rounded)),
                                  ],
                                ),
                              )
                            ]
                          ],
                        ),
                        // child: ListView.builder(
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemCount: controller.conList.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return Container(
                        //         padding: const EdgeInsets.symmetric(
                        //           vertical: 4,
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               controller.conList[index],
                        //               style: const TextStyle(
                        //                 fontSize: 16,
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap: () {
                        //                 controller.removeCondition(index);
                        //                 logger.i(index);
                        //               },
                        //               child: const Icon(
                        //                 Icons.remove_circle_outline,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     }),
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
