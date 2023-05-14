import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:nnz/src/services/share_auth_provider.dart';

class ShareDetailController extends GetxController {
  late final authImageController;

  List<ImageFile> authImageList = [];

  @override
  void onInit() {
    super.onInit();
    authImageController = MultiImagePickerController(
        maxImages: 1,
        withReadStream: true,
        allowedImageTypes: ['png', 'jpg', 'jpeg']);
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

  Future<void> sendAuthImage() async {
    try {
      final res = await ShareAuthProvider()
          .postShareAuth(authImage: authImageController.images[0]);
    } catch (err) {
      print("사진 에러에용");
      print(authImageController.images);
      print(err);
    }
  }
}
