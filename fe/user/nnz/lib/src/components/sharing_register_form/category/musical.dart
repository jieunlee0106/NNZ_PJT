import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

class MusicalCategory extends StatefulWidget {
  const MusicalCategory({super.key, this.selectItem});
  final selectItem;

  @override
  State<MusicalCategory> createState() => _MusicalCategoryState();
}

class _MusicalCategoryState extends State<MusicalCategory> {
  final controller = Get.put(SharingRegisterController());

  final logger = Logger();

  List<dynamic> showList = [];
  Widget showListResult() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Column(
        children: List.generate(
          showList.length,
          (index) {
            return GestureDetector(
              onTap: () {
                controller.sharingController.text = showList[index]["title"];
                controller.showId(showList[index]["id"]);
                logger.i(controller.showId.value);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        color: Colors.transparent.withOpacity(0.5),
                      )
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        "${showList[index]["poster"]}",
                        width: 120,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          // horizontal: 14,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              showList[index]["title"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "공연 기간",
                              style: TextStyle(
                                fontSize: 14,
                                color: Config.blackColor,
                              ),
                            ),
                            Text(
                              "${showList[index]["startDate"]}",
                              style: TextStyle(
                                  fontSize: 14, color: Config.blackColor),
                            ),
                            Text(
                              "${showList[index]["endDate"]}",
                              style: TextStyle(
                                  fontSize: 14, color: Config.blackColor),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "공연장소",
                              style: TextStyle(
                                fontSize: 14,
                                color: Config.blackColor,
                              ),
                            ),
                            Text(
                              showList[index]["location"],
                              style: TextStyle(
                                fontSize: 14,
                                color: Config.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
          ),
          controller: controller.empSearchController,
          onChanged: (value) async {
            logger.i("${controller.empSearchController.text}");
            showList = await controller.onSearchShow(
                category: widget.selectItem, title: value);
            logger.i(showList);
            setState(() {});
          },
        ),
        if (controller.empSearchController.text.length == 0) ...[
          showListResult()
        ] else ...[
          showList.isNotEmpty
              ? showListResult()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      iconData(
                        icon: ImagePath.sad,
                        size: 240,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "검색 결과가 없습니다.",
                        style: TextStyle(
                          color: Config.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
        ]
      ],
    );
  }
}
