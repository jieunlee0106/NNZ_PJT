import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SearchProvider extends GetConnect {
  final logger = Logger();

  @override
  void onInit() async {
    await dotenv.load();
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.defaultContentType = 'application/json';
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
  Future<Response> getSearch({
    required String type,
    required String q,
  }) async {
    final response = await get("search?=$type?=$q");
    return response;
    // try {
    //   final response = await get("/search?=$type?=$q");
    //   if (response.statusCode == 200) {
    //     return response.body;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }
  }

  //나눔 카테고리 조회
  Future<Response> getSharingCategories() async {
    final response = await get("/shows/categories");
    return response;
  }

  //나눔 공연 조회
  Future<Response> getSharingShow({
    required String category,
    required String title,
  }) async {
    final response = await get("/shows/search?category=$category&title=$title");
    return response;
  }

  //카테고리 조회
  Future<Response> getCategory({String? parent}) async {
    // try {
    //   final response =
    //       await get("/shows/categories?=$parent", headers: headers);
    //   if (response.statusCode == 200) {
    //     return response.body;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }

    final response = await get("/shows/categories?=$parent");
    return response;
  }

  //공연 목록 검색
  Future<Response> getShowList({required String category}) async {
    // try {
    //   final response = await get("/show?=$category", headers: headers);
    //   if (response.statusCode == 200) {
    //     return response.body;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }

    final response = await get('/show?=$category');
    return response;
  }
}
