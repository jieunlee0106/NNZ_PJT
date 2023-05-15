import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/model/popular_tag_model.dart';
import 'package:nnz/src/model/tag_list_model.dart';
import 'package:nnz/src/services/search_provider.dart';

class ShowSearchController extends GetxController {
  late final searchController;
  RxString searchText = "".obs;
  final logger = Logger();
  RxString category = ''.obs;
  RxBool hasFocus = false.obs;
  List<PopularTagModel> tagList = [];
  List<TagListModel> relatedTagList = [];
  @override
  void onInit() async {
    // TODO: implement onInit

    searchController = TextEditingController();
    await onPopularTag();
  }

  //인기 해시 태그
  Future<List<PopularTagModel>> onPopularTag() async {
    try {
      final response = await SearchProvider().getPopularTag();
      if (response.statusCode == 200) {
        tagList.clear();
        for (var data in response.body) {
          tagList.add(PopularTagModel.fromJson(data));
        }
        logger.i(tagList);
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

  //관련 검색 태그 api
  Future<List<TagListModel>> onRelatedSearch({required String text}) async {
    try {
      final response = await SearchProvider().getRelatedSearch(text: text);
      if (response.statusCode == 200) {
        relatedTagList.clear();
        for (var data in response.body) {
          relatedTagList.add(TagListModel.fromJson(data));
        }
        logger.i("관련 해시 태그 $relatedTagList");
        return relatedTagList;
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
