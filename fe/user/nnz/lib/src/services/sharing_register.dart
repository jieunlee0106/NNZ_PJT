import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/model/share_model.dart';

class SharingRegisterProvider extends GetConnect {
  final logger = Logger();
  String? token;
  final storage = const FlutterSecureStorage();
  final headers = {
    'Content-Type': 'application/json',
  };

  @override
  void onInit() async {
    await dotenv.load();
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(milliseconds: 5000);
    token = await storage.read(key: 'accessToken');
    super.onInit();
  }

  //나눔등록
  Future<Response> testShare(
      {required ShareModel shareModel, required var images}) async {
    logger.i(shareModel);
    final body = shareModel.toJson();
    final formData = FormData({
      "data": jsonEncode({
        "showId": 4399,
        "writer": shareModel.writer,
        "nanumDate": shareModel.nanumDate,
        "title": shareModel.title,
        "openTime": shareModel.openTime,
        'condition': shareModel.condition,
        "quantity": shareModel.quantity,
        "content": shareModel.content,
        "tags": shareModel.tags,
      })
    });
    for (int i = 0; i < images.length; i++) {
      formData.files.add(MapEntry(
          'images', MultipartFile(images[i].path, filename: images[i].name)));
    }
    for (var element in formData.files) {
      logger.i("${element.key} ${element.value.filename}");
    }
    token = Get.find<BottomNavController>().accessToken;
    logger.i("토큰 값 : $token");
    final response = await post(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums", formData,
        contentType: '', headers: {'Authorization': 'Bearer $token'});
    return response;
  }

  //나눔등록 api
  Future<Response> postShare(
      {required ShareModel shareModel, required var images}) async {
    final body = shareModel.toJson();
    logger.i(body);
    var formData = FormData(body);
    for (var i = 0; i < images.length; i++) {
      formData.files.add(
        MapEntry(
          'images',
          MultipartFile(images[i].path, filename: images[i].name),
        ),
      );
    }

    final response = await post("/nanums", formData,
        headers: {'Authorization': 'Bearer $token'});
    return response;
  }
}
