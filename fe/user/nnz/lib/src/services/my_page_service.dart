import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';

class MyPageService extends GetConnect {
  // final token = Get.find<BottomNavController>().accessToken;
  // String? token;
  final dio = Dio();

  @override
  void onInit() async {
    await dotenv.load();
    // dio.options.baseUrl = dotenv.env['BASE_URL'];
    // dio.options.headers['Authorization'] = 'Bearer $token';
    // dio.options.connectTimeout = timeout;
    super.onInit();
  }

  Future<dynamic> getMyPageInfo() async {
    try {
      final token = await Token.getAccessToken();
      print(token);
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/user-service/users',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response;
    } catch (e) {
      print('!!!!!Error occurred: $e');
      rethrow;
    }
  }
}
