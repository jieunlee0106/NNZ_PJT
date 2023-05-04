import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/model/show_list_model.dart';
import 'package:nnz/src/services/search_provider.dart';

class ShowSearchController extends GetxController {
  late final searchController;
  RxString searchText = "".obs;
  final logger = Logger();
  RxString category = ''.obs;
  RxBool hasFocus = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    searchController = TextEditingController();
  }

  Future<void> onChangeCategory(
      {required String text, required String type}) async {
    searchText(text);
    logger.i("text : $text, type : $type");
    try {
      final response = await SearchProvider().getSearch(type: type, q: text);
      if (response.statusCode == 200) {
        if (type == "nanum") {
          //나눔 검색 결과
          final showList = ShowListModel.fromJson(response.body);
        } else if (type == "show") {
          //공연 검색 결과
        }
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
