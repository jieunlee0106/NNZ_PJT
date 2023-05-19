import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

class ShareInsertImage extends StatelessWidget {
  ShareInsertImage({super.key});
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
