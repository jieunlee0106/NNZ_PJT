import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';
import 'package:nnz/src/model/register_model.dart';

class MyPageShareListService extends GetConnect {
  final token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMiIsImlzcyI6Im5ueiIsImlhdCI6MTY4Mzc3Nzg5OSwiYXV0aFByb3ZpZGVyIjoiTk5aIiwicm9sZSI6IlVTRVIiLCJpZCI6MTIsImVtYWlsIjoiamlqaUBnbWFpbC5jb20iLCJleHAiOjE2ODUwNzM4OTl9.LXCw6P2PfdC2MZNAVyPGLJrOixpVPhC6lczoeBuj4KqLu5l9ZMf6hmW6roO8WgduAFo8WhyQ_wI4aCigRWac5Q';
  //  SharingRegisterController().Token();
  final dio = Dio();

  @override
  void onInit() async {
    await dotenv.load();
    // dio.options.baseUrl = dotenv.env['BASE_URL'];
    dio.options.headers['Authorization'] = 'Bearer $token';
    // dio.options.connectTimeout = timeout;
    super.onInit();
  }

  Future<dynamic> getShareList({required String type}) async {
    try {
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/user-service/users/nanums?type=$type',
        options: Options(
          headers: {
            "authorization": "Bearer $token",
          },
        ),
      );
      print(type);
      print('리스트 통신 성공');
      return response;
    } catch (e) {
      print('!!!!!Error occurred: $e');
      throw e;
    }
  }
}
