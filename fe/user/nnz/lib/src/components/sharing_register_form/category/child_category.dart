import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/sharing_register_form/category/show_search.dart';

import '../../../controller/sharing_register_controller.dart';

class ChildCategory extends StatefulWidget {
  final selectItem;
  ChildCategory({super.key, required this.selectItem});
  @override
  State<ChildCategory> createState() => _ChildCategoryState();
}

class _ChildCategoryState extends State<ChildCategory> {
  List<String>? childList;
  String? childSelectedItem;
  final controller = Get.put(SharingRegisterController());
  final logger = Logger();
  @override
  void initState() async {
    super.initState();
    childList = await controller.getChildCategory(parent: widget.selectItem);
  }

  @override
  Widget build(BuildContext context) {
    return childList == []
        ? Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                ),
                controller: controller.concertController,
                onChanged: (value) {
                  logger.i(controller.sportsController.text);
                  controller.testText(value);
                },
              ),
            ],
          )
        : Column(
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
                        icon: Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.287,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                          ),
                        ),
                        hint: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          child: Text(
                            "스포츠 카테고리",
                          ),
                        ),
                        alignment: Alignment.center,
                        value: childSelectedItem,
                        onChanged: (newValue) {
                          setState(() {
                            childSelectedItem = newValue;
                          });
                        },
                        items: childList!.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 72,
                              ),
                              child: Text(item),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    childSelectedItem != null
                        ? ShowSearch(category: childSelectedItem,)
                        : Container(),
                  ],
                ),
              ),
            ],
          );
  }
}
