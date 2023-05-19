import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

class PerformanceTime extends StatefulWidget {
  const PerformanceTime({Key? key}) : super(key: key);

  @override
  _PerformanceTimeState createState() => _PerformanceTimeState();
}

class _PerformanceTimeState extends State<PerformanceTime> {
  DateTime? date;
  final controller = Get.put(SharingRegisterController());
  FocusNode? performStartFocusNode;
  FocusNode? performEndFocusNode;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    performStartFocusNode = FocusNode();
    performEndFocusNode = FocusNode();
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconData(
                  icon: ImagePath.giftDate,
                  size: 80,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 4.0,
                  ),
                  child: Text(
                    "나눔 일시",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    // width: Get.width * 0.45,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              focusNode: performStartFocusNode,
                              controller: controller.sharingDateController,
                              decoration: const InputDecoration(
                                hintText: "나눔 하실 날짜를 입력해주세요",
                                border: InputBorder.none,
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
                              );
                              if (temp != null) {
                                setState(() {
                                  date = temp;
                                });
                                final dateFormat =
                                    date.toString().substring(0, 10);
                                controller.sharingDateController.text =
                                    dateFormat;
                              }
                            },
                            child: const Icon(
                              Icons.calendar_today,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
