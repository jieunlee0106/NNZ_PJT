import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

class ShowSearch extends StatelessWidget {
  ShowSearch({super.key, required this.category});
  final category;
  final controller = Get.put(SharingRegisterController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        //검색을 하는 api가 있어야 됨
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
          ),
          controller: controller.showSearchController,
          onChanged: (value) {
            controller.onSearchShow(
                category: category,
                title: controller.showSearchController.text);
          },
        ),
      ],
    );
  }
}
