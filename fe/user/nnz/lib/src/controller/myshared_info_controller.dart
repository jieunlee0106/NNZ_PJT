import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nnz/src/model/share_info_model.dart';

class MysharedInfoController extends GetxController {
  final TextEditingController userlocationController = TextEditingController();
  final TextEditingController userlatController = TextEditingController();
  final TextEditingController userlongController = TextEditingController();
  final TextEditingController openTimeController = TextEditingController();
  final TextEditingController userClothController = TextEditingController();

  void registInfo() async {
    ShareInfoModel shareInfoModel = ShareInfoModel(
      nanumTime: userlocationController.text,
      location: "나눔 장소",
      lat: userlatController.text,
      lng: userlongController.text,
      outfit: userClothController.text,
    );
  }
}
