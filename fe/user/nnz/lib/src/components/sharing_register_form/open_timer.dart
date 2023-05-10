import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

import '../../config/config.dart';

class OpenTime extends StatefulWidget {
  const OpenTime({Key? key}) : super(key: key);

  @override
  State<OpenTime> createState() => _OpenTimeState();
}

class _OpenTimeState extends State<OpenTime> {
  final controller = Get.put(SharingRegisterController());
  final logger = Logger();
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
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
                icon: ImagePath.calendar,
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
                  "오픈시간",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Config.blackColor,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.openDateController,
                            decoration: const InputDecoration(
                              hintText: "오픈날짜",
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              DateTime? temp =
                                  await PlatformDatePicker.showDate(
                                context: context,
                                firstDate: DateTime(DateTime.now().year),
                                initialDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 5),
                                locale: const Locale('ko', 'KR'),
                                use24hFormat: true,
                              );
                              if (temp != null) {
                                setState(() {
                                  date = temp;
                                });
                                logger.i(date);
                                final dateFormat =
                                    date.toString().substring(0, 10);
                                controller.openDateController.text = dateFormat;
                              }
                            },
                            child: const Icon(Icons.calendar_today)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Config.blackColor,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.openTimeController,
                              decoration: const InputDecoration(
                                hintText: "오픈시간",
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () async {
                                TimeOfDay? temp =
                                    await PlatformDatePicker.showTime(
                                  context: context,
                                  initialTime: time,
                                  showCupertino: true,
                                  use24hFormat: true,
                                );
                                if (temp != null) {
                                  setState(() {
                                    time = temp;
                                  });
                                }
                                logger.i(controller.openDateController.text);
                                final timeFormat =
                                    time.toString().substring(10, 15);
                                controller.openTimeController.text = timeFormat;
                                logger.i(controller.openTimeController.text);
                                String test =
                                    "${controller.openDateController.text}T${controller.openTimeController.text}";

                                logger.i(test);
                              },
                              child: const Icon(Icons.timer)),
                        ],
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
