import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

class SportsCategory extends StatefulWidget {
  const SportsCategory({super.key, this.childCategoriesList});
  final childCategoriesList;
  @override
  State<SportsCategory> createState() => _SportsCategoryState();
}

class _SportsCategoryState extends State<SportsCategory> {
  List<String> _sportsItems = [];
  String? _selectedSports;
  final controller = Get.put(SharingRegisterController());
  final logger = Logger();
  List<dynamic> showList = [];
  @override
  void initState() {
    super.initState();
    _sportsItems = widget.childCategoriesList;

    test();
  }

  void test() async {
    showList = await controller.onSearchShow(
        category: _selectedSports ??
            _sportsItems.first, // 카테고리를 선택하지 않았다면 첫번째 항목을 선택합니다.
        title: controller.nempSearchController.text);
    logger.i(showList);
    setState(() {}); // showList를 변경했으므로 setState()를 호출합니다.
  }

  Widget notShowList() {
    return Column(children: [
      for (var item in showList)
        GestureDetector(
          onTap: () {
            controller.sharingController.text = item["title"];
            controller.showId(item["id"]);
            logger.i(controller.sharingController.text);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"],
                  style: TextStyle(
                    color: Config.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item["startDate"],
                  style: TextStyle(
                    color: Config.blackColor,
                    fontSize: 14,
                  ),
                ),
                item["location"] == null
                    ? Container()
                    : Text(
                        item["location"],
                        style: TextStyle(
                          color: Config.blackColor,
                          fontSize: 14,
                        ),
                      ),
              ],
            ),
          ),
        ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),
                    isDense: true,
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    icon: const Padding(
                      padding: EdgeInsets.only(
                        left: 42,
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ),
                    hint: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Text(
                        "카테고리 선택해주세요",
                      ),
                    ),
                    value: _selectedSports,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSports = newValue;
                      });
                      showList.clear();
                    },
                    items: _sportsItems.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                          ),
                          child: Text(item),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                _selectedSports != null
                    ? Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        //검색을 하는 api가 있어야 됨
                        TextField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                          ),
                          controller: controller.nempSearchController,
                          onChanged: (value) async {
                            showList.clear();
                            showList = await controller.onSearchShow(
                                category: _selectedSports!,
                                title: controller.nempSearchController.text);
                            logger.i("과연 $showList");
                            setState(() {});
                          },
                        ),
                        if (controller.nempSearchController.text.length ==
                            0) ...[
                          notShowList()
                        ] else if (controller
                                .nempSearchController.text.length >=
                            1) ...[
                          showList.isNotEmpty
                              ? notShowList()
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
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
                                        "검색결과가 없습니다.",
                                        style: TextStyle(
                                          color: Config.blackColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ])
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
