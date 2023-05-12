import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';

class MyPageService extends GetConnect {
  // final token =
  //     'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMCIsImlzcyI6Im5ueiIsImlhdCI6MTY4MzY5ODQ3MCwiYXV0aFByb3ZpZGVyIjoiTk5aIiwicm9sZSI6IlVTRVIiLCJpZCI6MTAsImVtYWlsIjoiYXNkYXNkQGdtYWkuY29tIiwiZXhwIjoxNjgzNzAyMDcwfQ.468vxyCopH-PT__CWw16bvZj00NkhF2L7Xq-OgPL96xejPfmjcuHijceO3Ta7LwPIF7wb7FFaY6KTlrSAqLvYA';
  final token = Get.find<BottomNavController>().accessToken;
  final dio = Dio();

  @override
  void onInit() async {
    await dotenv.load();
    // dio.options.baseUrl = dotenv.env['BASE_URL'];
    dio.options.headers['Authorization'] = 'Bearer $token';
    // dio.options.connectTimeout = timeout;
    super.onInit();
  }

  Future<dynamic> getMyPageInfo() async {
    try {
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/user-service/users',
        options: Options(
          headers: {
            "authorization": "Bearer $token",
          },
        ),
      );
      return response;
    } catch (e) {
      print(token);
      print('!!!!!Error occurred: $e');
      rethrow;
    }
  }
}
