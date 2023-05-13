import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/config/token.dart';
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
        'isCertification': shareModel.isCertification,
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
    token = await Token.getAccessToken();
    logger.i("토큰 값 : $token");
    final response = await post(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums", formData,
        contentType: '', headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 500) {
      logger.e("에러 들어왔어? ${response.statusCode}");
    } else if (response.statusCode == 401) {
      //토큰 재발급 받기
      await Token.refreshAccessToken();
      final newToken = await Token.getAccessToken();

      //요청 다시 보내기
      final newResponse = await post(
          "https://k8b207.p.ssafy.io/api/nanum-service/nanums", formData,
          contentType: '', headers: {'Authorization': 'Bearer $newToken'});

      return newResponse;
    }
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
