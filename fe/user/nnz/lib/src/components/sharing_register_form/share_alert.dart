import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/sharing_register_form/category/musical.dart';
import 'package:nnz/src/components/sharing_register_form/category/sports.dart';

import '../../config/config.dart';
import '../../controller/sharing_register_controller.dart';

class ShareAlert extends StatefulWidget {
  const ShareAlert({super.key});

  @override
  State<ShareAlert> createState() => _ShareAlertState();
}

class _ShareAlertState extends State<ShareAlert> {
  final logger = Logger();

  final controller = Get.put(SharingRegisterController());

  List<String> _items = [];
  List<String> _childItems = [];
  String? _selectedItem;
  @override
  void initState() {
    super.initState();
    onGetParentCategory();
  }

  void onGetParentCategory() async {
    _items = await controller.getParentCategory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 24,
          ),
          title: const Text(
            "공연선택",
            style: TextStyle(fontSize: 16),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _items.isEmpty
                        ? const CircularProgressIndicator()
                        : DropdownButton<String>(
                            underline: Container(),
                            isDense: true,
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            icon: Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.3,
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                              ),
                            ),
                            hint: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                "나눔 카테고리",
                              ),
                            ),
                            value: _selectedItem,
                            onChanged: (newValue) async {
                              _childItems.clear();
                              setState(() {
                                _selectedItem = newValue;
                              });
                              _childItems = await controller.getChildCategory(
                                  index: _items.indexOf(newValue!));
                              setState(() {});
                            },
                            items: _items.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(item),
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                  _selectedItem == null
                      ? Container()
                      : _childItems.isEmpty
                          ? MusicalCategory(selectItem: _selectedItem)
                          : SportsCategory(childCategoriesList: _childItems),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.nempSearchController.text = '';
                controller.empSearchController.text = '';
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Config.yellowColor,
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text(
                  '선택완료',
                  style: TextStyle(
                    color: Config.blackColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
