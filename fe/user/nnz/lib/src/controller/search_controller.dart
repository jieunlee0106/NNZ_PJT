import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/services/search_provider.dart';

class ShowSearchController extends GetxController {
  late final searchController;
  RxString searchText = "".obs;
  final logger = Logger();
  RxString category = ''.obs;
  RxBool hasFocus = false.obs;
  List<String> tagList = [];
  @override
  void onInit() async {
    // TODO: implement onInit

    searchController = TextEditingController();
    await onPopularTag();
  }

  //인기 해시 태그
  Future<List<String>> onPopularTag() async {
    try {
      final response = await SearchProvider().getPopularTag();
      if (response.statusCode == 200) {
        for (var tag in response.body) {
          tagList.add(tag);
        }
        return tagList;
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

  //나눔 및 검색
  Future<void> onChangeCategory(
      {required String text, required String type}) async {
    searchText(text);
    logger.i(searchText.value);
    logger.i("text : $text, type : $type");
    // try {
    //   final response = await SearchProvider().getSearch(type: type, q: text);
    //   if (response.statusCode == 200) {
    //     if (type == "nanum") {
    //       //나눔 검색 결과
    //       final showList = ShowListModel.fromJson(response.body);
    //     } else if (type == "show") {
    //       //공연 검색 결과
    //     }
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
}
