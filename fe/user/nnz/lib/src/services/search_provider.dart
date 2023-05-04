import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SearchProvider extends GetConnect {
  final logger = Logger();
  @override
  void onInit() async {
    await dotenv.load();
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(milliseconds: 5000);
    super.onInit();
  }

  //인기 해시 태그 조회
  Future<Response> getPopularTag() async {
    try {
      final response = await get("/tags");
      return response;
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }

  //나눔 / 공연 목록 조회
  Future<Response> getSearch({required String type, required String q}) async {
    try {
      final response = await get("/search?=$type?=$q");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        final errorMessage = "(${response.statusCode}): ${response.body}";
        logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
