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

  //공연 목록 검색
  Future<Response> getShowList({required String category}) async {
    // try {
    //   final response = await get("/show?=$category", headers: headers);
    //   if (response.statusCode == 200) {
    //     return response.body;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }

    final response = await get('/show?=$category', headers: headers);
    return response;
  }

  //카테고리 조회
  Future<Response> getCategory({required String parent}) async {
    // try {
    //   final response =
    //       await get("/shows/categories?=$parent", headers: headers);
    //   if (response.statusCode == 200) {
    //     return response.body;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }

    final response = await get("/shows/categories?=$parent", headers: headers);
    return response;
  }

  //나눔등록
  void testShare({required ShareModel shareModel, required var images}) async {
    final body = shareModel.toJson();
    List<MultipartFile> multipartImageList = [];

    var formData = FormData(body);

    for (var i = 0; i < images.length; i++) {
      MultipartFile multipartFile =
          MultipartFile(images[i].path, filename: images[i].name);
      multipartImageList.add(multipartFile);
    }

    // for (var element in formData.files) {
    //   logger.i(element.toString());
    // }
    // logger.i("들어왔습니다. ${formData.files[0].value}");
  }

  //나눔등록 api
  Future<Response> postShare(
      {required ShareModel shareModel, required var images}) async {
    final body = shareModel.toJson();
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
