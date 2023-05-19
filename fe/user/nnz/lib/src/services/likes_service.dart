import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';
import 'package:nnz/src/model/register_model.dart';

class LikesService extends GetConnect {
  // final token = Get.find<BottomNavController>().accessToken;
  String? token;
  final dio = Dio();
  final userId = Get.find<BottomNavController>().userId;

  @override
  void onInit() async {
    await dotenv.load();
    // dio.options.baseUrl = dotenv.env['BASE_URL'];
    // dio.options.headers['Authorization'] = 'Bearer $token';
    // dio.options.connectTimeout = timeout;
    super.onInit();
  }

  Future<dynamic> getLikesList() async {
    final token = await Token.getAccessToken();

    try {
      print('찜 리스트 통신한다');
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/user-service/users/bookmarks?userId=$userId',
        options: Options(
          headers: {
            "authorization": "Bearer $token",
          },
        ),
      );
      print('찜 리스트 통신 성공');
      return response;
    } catch (e) {
      print('!!!!!Error occurred: $e');
      throw e;
    }
  }
}
