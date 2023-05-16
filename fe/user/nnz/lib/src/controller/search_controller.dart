import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/model/popular_tag_model.dart';
import 'package:nnz/src/model/search_show_list_model.dart' as searchShow;
import 'package:nnz/src/model/searh_nanum_list_model.dart' as searchNanum;
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
  List<searchNanum.Content> nanumList = [];
  List<searchShow.Content> showList = [];
  List<String> rTagList = [];
  RxString type = RxString("");
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

  //나눔 검색 api
  Future<List<searchNanum.Content>> getNanumList({required String q}) async {
    try {
      final response = await SearchProvider().getNanumsSearch(q: q);
      if (response.statusCode == 200) {
        rTagList.clear();
        nanumList.clear();
        for (var tag in response.body["relatedTags"]) {
          rTagList.add(tag["tag"]);
        }
        logger.i("나눔리스트에 들어왔어염>>>>> $rTagList");
        for (var data in response.body["nanums"]["content"]) {
          nanumList.add(searchNanum.Content.fromJson(data));
        }
        return nanumList;
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

  //공연 검색 api
  Future<List<searchShow.Content>> getShowList({required String q}) async {
    try {
      final response = await SearchProvider().getShowsSearch(q: q);
      if (response.statusCode == 200) {
        rTagList.clear();
        showList.clear();
        for (var tag in response.body["relatedTags"]) {
          rTagList.add(tag["tag"]);
        }
        for (var data in response.body["shows"]["content"]) {
          showList.add(searchShow.Content.fromJson(data));
        }
        return showList;
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
