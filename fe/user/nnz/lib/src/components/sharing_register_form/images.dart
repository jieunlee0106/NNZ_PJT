import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../controller/sharing_register_controller.dart';

class Images extends StatelessWidget {
  Images({super.key});
  final controller = Get.put(SharingRegisterController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: MultiImagePickerView(
      addButtonTitle: "이미지를 업로드 해주세요",
      controller: controller.imageController,
    ));
  }
}
