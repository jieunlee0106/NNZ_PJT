import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProposeController extends GetxController {
  late final showTitleController;
  late final showUrlController;
  @override
  void onInit() {
    super.onInit();
    showTitleController = TextEditingController();
    showUrlController = TextEditingController();
  }
}
