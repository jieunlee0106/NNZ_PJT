import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';
import 'package:nnz/src/model/register_model.dart';

class TagService extends GetConnect {
  final dio = Dio();

  @override
  void onInit() async {
    await dotenv.load();
    // dio.options.baseUrl = dotenv.env['BASE_URL'];

    // dio.options.connectTimeout = timeout;
    super.onInit();
  }

  // 태그 나눔
  Future<dynamic> getNanumTagList({required String tagName}) async {
    print('$tagName 통신 한다');
    try {
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/nanum-service/nanums/tag',
        queryParameters: {'tag': tagName},
      );
      print('통신 성공');
      print(response);
      return response;
    } catch (e) {
      print('!!!!!Error occurred: $e');
      throw e;
    }
  }

  // 태그 공연
  Future<dynamic> getShowTagList({required String tagName}) async {
    print('$tagName 통신 한다');
    try {
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/show-service/shows/tag',
        queryParameters: {'tag': tagName},
      );
      print('통신 성공');
      print(response);
      return response;
    } catch (e) {
      print('!!!!!Error occurred: $e');
      throw e;
    }
  }
}
