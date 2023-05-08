import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/sharing_register_form/category/esports.dart';
import 'package:nnz/src/components/sharing_register_form/category/movies.dart';
import 'package:nnz/src/components/sharing_register_form/category/musical.dart';
import 'package:nnz/src/components/sharing_register_form/category/sports.dart';
import 'package:nnz/src/components/sharing_register_form/category/theator.dart';

import '../../config/config.dart';
import '../../controller/sharing_register_controller.dart';
import 'category/concert.dart';

class ShareAlert extends StatefulWidget {
  const ShareAlert({super.key});

  @override
  State<ShareAlert> createState() => _ShareAlertState();
}

class _ShareAlertState extends State<ShareAlert> {
  final logger = Logger();

  final controller = Get.put(SharingRegisterController());
  final List<String> _items = ['콘서트', '뮤지컬', '연극', '영화', '스포츠', 'e스포츠'];
  List<String>? _items2;

  String? _selectedItem;
  @override
  void initState() {
    super.initState();
    onGetParentCategory();
  }

  void onGetParentCategory() async {
    _items2 = await controller.getParentCategory();
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
                    child: DropdownButton<String>(
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
                      alignment: Alignment.center,
                      value: _selectedItem,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItem = newValue;
                        });
                      },
                      items: _items.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 60,
                            ),
                            child: Text(item),
                          ),
                        );
                      }).toList(),
                      //
                      // items: controller.pCategories.map((item) {
                      //   return DropdownMenuItem(
                      //     value: item,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //         right: 60,
                      //       ),
                      //       child: Text(item),
                      //     ),
                      //   );
                      // }).toList(),
                    ),
                  ),
                  //
                  // for(var item in  _items)...[
                  //   if(_selectedItem == item)
                  //     ChildCategory(selectItem: _selectedItem),
                  // ],
                  _selectedItem == _items[0] ? ConcertCategory() : Container(),
                  _selectedItem == '뮤지컬' ? MusicalCategory() : Container(),
                  _selectedItem == '연극' ? TheatorCategory() : Container(),
                  _selectedItem == '영화' ? MovieCategory() : Container(),
                  _selectedItem == '스포츠' ? const SportsCategory() : Container(),
                  _selectedItem == 'e스포츠'
                      ? const EsportsCategory()
                      : Container(),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.onChange(controller.testText.value);
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
