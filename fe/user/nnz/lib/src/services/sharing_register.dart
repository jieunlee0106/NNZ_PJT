import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/model/share_model.dart';

class SharingRegisterProvider extends GetConnect {
  final logger = Logger();
  final headers = {
    'Content-Type': 'application/json',
  };

  @override
  void onInit() async {
    await dotenv.load();
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(milliseconds: 5000);
    super.onInit();
  }

  //나눔등록
  Future<Response> testShare(
      {required ShareModel shareModel, required var images}) async {
    logger.i(shareModel);
    final body = shareModel.toJson();
    final formData = FormData({"data": body});
    for (int i = 0; i < images.length; i++) {
      formData.files.add(MapEntry(
          'images', MultipartFile(images[i].path, filename: images[i].name)));
    }

    final response = await post(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums", formData);
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

    final response =
        await post("/nanums", formData, contentType: 'multipart/form-data');
    return response;
  }
}
