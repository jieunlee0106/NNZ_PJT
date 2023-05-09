import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:get/get_connect/connect.dart";
import 'package:dio/dio.dart';

class CategoryService extends GetConnect {

  @override
  void onInit() async {
    await dotenv.load();
    // httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(milliseconds: 5000); 
    super.onInit();
  }

  Future<dynamic> getCategoryList({required String categoryName}) async {
    final response = await Dio().get(
      'https://k8b207.p.ssafy.io/api/show-service/shows',
      queryParameters: {'category': categoryName},
    );

    return response; // resposne가 아닌 response로 수정
  }
}
