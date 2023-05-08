import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class ShareDetailController extends GetxController {
  late final authImageController;
  late final userclothController;

  List<ImageFile> authImageList = [];

  @override
  void onInit() {
    super.onInit();
    authImageController = MultiImagePickerController(
        maxImages: 5,
        withReadStream: true,
        allowedImageTypes: ['png', 'jpg', 'jpeg']);
    userclothController = TextEditingController();
  }

  void onApplyShare() {
    if (authImageController.images.length == 0) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            content: const Text("인증 사진을 넣어주세요"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  FocusScope.of(context).unfocus();
                },
                child: const Text("확인"),
              )
            ],
          );
        },
      );
    } else {
      authImageList.clear();
      for (var image in authImageController.images) {
        authImageList.add(image);
      }
    }
  }
}
