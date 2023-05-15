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

  // 태그 API 작성하기

  // Future<dynamic> getLikesList() async {
  //   try {
  //     print('찜 리스트 통신한다');
  //     final response = await dio.get(
  //       'https://k8b207.p.ssafy.io/api/user-service/users/bookmarks?userId=12',
  //     );
  //     print('찜 리스트 통신 성공');
  //     return response;
  //   } catch (e) {
  //     print('!!!!!Error occurred: $e');
  //     throw e;
  //   }
  // }
}
