import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ShowSearchController extends GetxController {
  late final searchController;
  RxString searchText = "".obs;
  final logger = Logger();
  RxString category = ''.obs;
  RxBool hasFocus = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    searchController = TextEditingController();
  }

  void onChangeCategory({required String value}) {
    logger.i(value.isEmpty);
    searchText(value);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
