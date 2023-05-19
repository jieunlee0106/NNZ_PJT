import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

import '../../config/config.dart';
import '../icon_data.dart';

class PeopleCount extends StatelessWidget {
  PeopleCount({super.key});
  final controller = Get.put(SharingRegisterController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: Colors.white,
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  iconData(
                    icon: ImagePath.peopleCount,
                    size: 80,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                  ),
                  const Text(
                    "인원수",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 60,
                vertical: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.peopleCount.value > 0) {
                        controller.onDecrease();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Config.blackColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "-",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "${controller.peopleCount.value}",
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onIncrease();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Config.blackColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "+",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
