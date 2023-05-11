import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nnz/src/model/share_info_model.dart';
import 'package:nnz/src/services/myshare_info_provider.dart';

class MysharedInfoController extends GetxController {
  final TextEditingController userlocationController = TextEditingController();
  final TextEditingController userlatController = TextEditingController();
  final TextEditingController userlongController = TextEditingController();
  final TextEditingController openTimeController = TextEditingController();
  final TextEditingController userClothController = TextEditingController();

  final storage = const FlutterSecureStorage();
  Future<String> getToken() async {
    final accessToken = await storage.read(key: 'accessToken');
    return accessToken!;
  }

  void onregistInfo() async {
    ShareInfoModel shareInfoModel = ShareInfoModel(
      nanumTime: openTimeController.text,
      location: "나눔 장소",
      lat: userlatController.text,
      lng: userlongController.text,
      outfit: userClothController.text,
    );
    try {
      final res = await MyShareInfoProvider()
          .postShareInfo(shareInfoModel: shareInfoModel);
      print("성공이야");
      print(shareInfoModel.nanumTime);
      print(res);
    } catch (err) {
      print("에러야");
      print(err);
    }
  }
}
