import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:get/get_connect/connect.dart";
import 'package:dio/dio.dart';

class CategoryService extends GetConnect {
  final dio = Dio();

  @override
  void onInit() async {
    await dotenv.load();
    // httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(milliseconds: 5000);
    super.onInit();
  }

  // 콘서트, 뮤지컬, 연극, 뮤직 페스티벌
  Future<dynamic> getShowCategoryList({required String categoryName}) async {
    print('$categoryName 통신 한다');
    try {
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/show-service/shows',
        queryParameters: {'category': categoryName},
      );
      print('통신 성공');
      print(response);
      return response;
    } catch (e) {
      print('!!!!!Error occurred: $e');
      throw e;
    }
  }

  // 스포츠
  Future<dynamic> getCategoryList({required String categoryName}) async {
    final response = await Dio().get(
      'https://k8b207.p.ssafy.io/api/show-service/shows',
      queryParameters: {'category': categoryName},
    );

    return response;
  }

  // Hot 한 공연
  Future<dynamic> getHotList({required String categoryName}) async {
    print('$categoryName 인기 공연통신 한다');
    try {
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/show-service/shows/popular',
        queryParameters: {'category': categoryName},
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
