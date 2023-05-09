import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class CategoryService {
  // 카테고리 목록 조회
  Future<dynamic> getCategoryList() async {
    final options = BaseOptions(
      // baseUrl: 'https://k8b207.p.ssafy.io/api/show-service',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    final dio = Dio(options);

    final response = await dio.get(
      "https://k8b207.p.ssafy.io/api/show-service/shows?category=야구",
    );

    return response;
  }
}
