import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/services/search_provider.dart';

class ProposeController extends GetxController {
  late final showTitleController;
  late final showUrlController;
  @override
  void onInit() {
    super.onInit();
    showTitleController = TextEditingController();
    showUrlController = TextEditingController();
  }

  Future<void> onReqShow() async {
    try {
      final response = await SearchProvider().postReqShow(
          title: showTitleController.text, path: showUrlController.text);
      if (response.statusCode == 204) {
        Logger().i("공연등록완료");
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('공연 요청 되었습니다.'),
          ),
        );
        Get.until((route) => route.isFirst);
        Get.offNamed("/app");
      } else {
        Logger().i("${response.statusCode} ${response.statusText}");
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
